#!/usr/bin/env python3
"""
Backup existing dotfiles to ~/.dotfiles_backup/ and link new ones from repo

run in the .dotfiles directory with:
    ./install_dotfiles.py
to restore the earlier backup dotfiles
    ./install_dotfiles.py -r
"""

import argparse
import shutil
from pathlib import Path, PurePath

DOTFILES = [
    "vim",
    "vim/vimrc",
    "bash/bashrc",
    "bash/bash_profile",
    "bash/bash_aliases",
    "git/gitconfig",
    "git/gitignore_global",
    "tmux/tmux.conf",
]

HOME_DIR = Path.home()
BACKUP_DIR = HOME_DIR / ".dotfiles_backup"


def check_dotfiles_list():
    """ Make sure defined dotfiles list is good """

    for file in DOTFILES:
        assert Path(file).exists(), (
            "Entry {}:{} in "
            "DOTFILES list does not exist".format(DOTFILES.index(file), file)
        )


def backup_old():
    """ move existing dotfiles to .dotfiles_backup dir """

    assert not BACKUP_DIR.exists(), (
        "~/.dotfiles_backup already exists! "
        "Please move or delete it before running script. Exiting."
    )
    BACKUP_DIR.mkdir()
    for file in DOTFILES:
        # print("{}:{} exists!".format(DOTFILES.index(file), file))
        basename = "." + PurePath(file).name
        # print(basename)
        oldpath = HOME_DIR / basename
        # print("oldpath: ", oldpath)
        newpath = BACKUP_DIR / basename
        # print("newpath: ", newpath)
        if oldpath.exists() or oldpath.is_symlink():
            shutil.copy(oldpath, newpath, follow_symlinks=False)
            oldpath.unlink()


def restore_backup():
    """ restore backup dotfiles into HOME, does not destroy backup """

    assert BACKUP_DIR.exists(), "~/.dotfiles_backup does NOT exists! Exiting"
    for file in DOTFILES:
        basename = "." + PurePath(file).name

        src_path = BACKUP_DIR / basename
        dst_path = HOME_DIR / basename

        if src_path.exists() or src_path.is_symlink():
            try:
                shutil.copy(src_path, dst_path, follow_symlinks=False)
            except shutil.SameFileError:
                print(dst_path, "same as backup, skipped restore")
            else:
                print(dst_path, "restored from backup")


def symlink_new():
    """ link new dotfiles from repo """

    for file in DOTFILES:
        # print("{}:{} exists!".format(DOTFILES.index(file), file))
        basename = "." + PurePath(file).name
        # print(basename)
        newpath = HOME_DIR / basename
        # print(newpath)
        link_target = HOME_DIR / ".dotfiles" / file
        # print(link_target)
        assert not newpath.exists() and not newpath.is_symlink(), (
            "Old file ({}) was not cleaned up "
            "correctly after backup and still exists!".format(newpath)
        )
        newpath.symlink_to(link_target, link_target.is_dir())


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
