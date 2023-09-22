## subtree magic

Based on [this](https://gist.github.com/tswaters/542ba147a07904b1f3f5)

### setup

```shell
# add remote, create new tracking branch, 
git remote add -f klicky-upstream git@github.com:jlas1/Klicky-Probe.git
git checkout -b upstream/klicky klicky-upstream/main

# split off subdir of tracking branch into separate branch
git subtree split -q --squash --prefix=Klipper_macros --annotate="[klicky] " --rejoin -b merging/klicky

# add separate branch as subdirectory on main.
git checkout main
git subtree add --prefix=klipper/config/modules.d/klicky --squash merging/klicky
```

### update

```shell
# switch back to tracking branch, fetch & rebase.
git checkout upstream/klicky 
git pull klicky-upstream/main

# update the separate branch with changes from upstream
git subtree split -q --prefix=Klipper_macros --annotate="[klicky] " --rejoin -b merging/klicky

# switch back to main and use subtree merge to update the subdirectory
git checkout main
git subtree merge -q --prefix=klipper/config/modules.d/klicky --squash merging/klicky
```