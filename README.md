
How it works :
---
It uses GNU stow to install my dotfiles in the home directory.

```
git clone https://github.com/AdrienLucas/dotfiles.git
cd dotfiles
make
```

Later you can unstow them by doing

```
make uninstall
```

What will be installed :
 * system dependencies (via APT)
   - sudo make system-depencies #Only install very low level packages needed in a lot of cases.
   - sudo make system-additional-packages #Install a bunch of packages commonly needed.
   - sudo make system # Do the two above in one.
 * bash dotfiles (bashrc, bash_alias)
   - make install bash-dotfiles
 * vim configuration
 * session dotfiles (xprofile)
 * jolicode/phaudit (in docker)
 * some bash scripts
 * some third-party software (see the list below)

System dependencies (via APT)
---

```
git clone https://github.com/AdrienLucas/dotfiles.git
cd dotfiles
sudo make system-depencies
sudo make system-additional-packages

```

Third-party software :
---

 * Composer
   - make ~/bin/composer
 * Homestead
   - make ~/bin/homestead
