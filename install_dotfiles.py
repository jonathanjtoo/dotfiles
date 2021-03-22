#!/usr/bin/env python3
"""
Backup existing dotfiles to ~/.dotfiles_backup/ and link new ones from repo

run in the .dotfiles directory with:
    ./install_dotfiles.py
to restore the earlier backup dotfiles
    ./install_dotfiles.py -r
"""

import argparse
import os
import shutil
import filecmp

DOTFILES = [
    "vim/vimrc",
    "bash/bashrc",
    "bash/bash_profile",
    "bash/bash_aliases",
    "zsh/zshrc",
    "git/gitconfig",
    "git/gitignore_global",
    "tmux/tmux.conf",
]

HOME_DIR = os.path.expanduser("~")
BACKUP_DIR = os.path.join(HOME_DIR, ".dotfiles_backup")


def check_dotfiles_list():
    """ Make sure defined dotfiles list is good """

    for file in DOTFILES:
        assert os.path.exists(file), (
            "Entry {}:{} in "
            "DOTFILES list does not exist".format(DOTFILES.index(file), file)
        )


def backup_old():
    """ move existing dotfiles to .dotfiles_backup dir """

    assert not os.path.exists(BACKUP_DIR), (
        "~/.dotfiles_backup already exists! "
        "Please move or delete it before running script. Exiting."
    )
    os.mkdir(BACKUP_DIR)
    for file in DOTFILES:
        # print("{}:{} exists!".format(DOTFILES.index(file), file))
        basename = "." + os.path.basename(file)
        # print(basename)
        src_path = os.path.join(HOME_DIR, basename)
        # print("src_path: ", src_path)
        dst_path = os.path.join(BACKUP_DIR, basename)
        # print("dst_path: ", dst_path)
        if os.path.exists(src_path) or os.path.islink(src_path):
            shutil.copy(src_path, dst_path, follow_symlinks=False)
            os.remove(src_path)


def restore_backup():
    """ restore backup dotfiles into HOME, does not destroy backup """

    assert os.path.exists(
        BACKUP_DIR), "~/.dotfiles_backup does NOT exists! Exiting"
    for file in DOTFILES:
        basename = "." + os.path.basename(file)

        src_path = os.path.join(BACKUP_DIR, basename)
        dst_path = os.path.join(HOME_DIR, basename)

        if os.path.exists(src_path) or os.path.islink(src_path):

            # check if link is duplicate
            if os.path.islink(src_path) and os.path.islink(dst_path):
                if os.readlink(src_path) == os.readlink(dst_path):
                    print(dst_path, "link points to same file, skipped restore")
                    continue
            # check if physical file is duplicate
            if os.path.exists(src_path) and os.path.exists(dst_path):
                if filecmp.cmp(src_path, dst_path):
                    print(dst_path, "has same content, skipped restore")
                    continue

            # need to remove dst_path if either dst or src is a symlink
            if os.path.islink(dst_path) or os.path.islink(src_path):
                os.remove(dst_path)

            shutil.copy(src_path, dst_path, follow_symlinks=False)
            print(dst_path, "restored from backup")


def symlink_new():
    """ link new dotfiles from repo """

    for file in DOTFILES:
        # print("{}:{} exists!".format(DOTFILES.index(file), file))
        basename = "." + os.path.basename(file)
        # print(basename)
        newpath = os.path.join(HOME_DIR, basename)
        # print(newpath)
        link_target = os.path.join(HOME_DIR, ".dotfiles", file)
        # print(link_target)
        assert not os.path.exists(newpath) and not os.path.islink(newpath), (
            "Old file ({}) was not cleaned up "
            "correctly after backup and still exists!".format(newpath)
        )
        os.symlink(link_target, newpath, os.path.isdir(link_target))
        print(newpath, "now symlinked to", link_target)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-r",
        "--restore",
        action="store_true",
        dest="restore",
        default=False,
        help="restore dotfiles from backup",
    )
    args = parser.parse_args()

    check_dotfiles_list()

    if args.restore:
        restore_backup()
    else:
        backup_old()
        symlink_new()
