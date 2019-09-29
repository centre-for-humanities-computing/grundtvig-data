#%%
import pandas as pd
from glob import glob
import os
import re
#%%
directory1 = "xmlFilesEdit"
directory2 = "version110"
directory3 = "ubehandledeFiler"

#%%
namegrab = re.compile("\d{4}_[\d\w]*")

#%%
dir1files = glob(os.path.join(directory1, "*/*_txt.xml"), recursive=True)
print(len(dir1files))
dir1files = [re.search(namegrab, file).group(0) for file in dir1files]
print(len(dir1files))
dir1files = [x.replace("_txt", "") for x in dir1files]
dir1files
#%%
dir2files = glob(os.path.join(directory2, "*_txt.xml"), recursive=True)
print(len(dir2files))
dir2files = [re.search(namegrab, file).group(0) for file in dir2files]
dir2files
dir2files = [x.replace("_txt", "") for x in dir2files]
dir2files
#%%
dir3files = glob(os.path.join(directory3, "*.xml"), recursive=True)
print(len(dir3files))
dir3files = [re.search(namegrab, file).group(0) for file in dir3files]
dir3files

#%%
uniques = list(set().union(dir1files, dir2files, dir3files))
print(len(uniques))

#%%
dir2files_pruned = [f for f in dir2files if f not in dir1files]
len(dir2files_pruned)

#%%
dir3files_pruned = [f for f in dir3files if f not in dir1files and f not in dir2files]
len(dir3files_pruned)

#%%
uniques == list(set().union(dir1files, dir2files_pruned, dir3files_pruned))

#%%
dir1 = glob(os.path.join(directory1, "*/*_txt.xml"), recursive=True)
dir1_paths = []
for f in dir1:
    for a in dir1files:
        if a + "_txt.xml" in f:
            dir1_paths.append(f)
            continue
len(dir1_paths) == len(dir1files)

#%%
len(dir2files)
#%%
dir2 = glob(os.path.join(directory2, "*_txt.xml"), recursive=True)
dir2_paths = []
for f in dir2:
    for a in dir2files_pruned:
        if a + "_txt.xml" in f:
            dir2_paths.append(f)
            continue
len(dir2_paths) == len(dir2files_pruned)

#%%
dir3 = glob(os.path.join(directory3, "*.xml"), recursive=True)
dir3_paths = []
for f in dir3:
    for a in dir3files_pruned:
        if a + ".xml" in f:
            dir3_paths.append(f)
            continue
len(dir3_paths) == len(dir3files_pruned)
#%%
from shutil import copyfile
import ntpath
files_list = [dir1_paths, dir2_paths, dir3_paths]
for i in range(3):
    directory = directories[i]
    files = files_list[i]
    for f in files:
        source = f
        destination = os.path.join("Unique_files", ntpath.basename(f))
        copyfile(source, destination)

#%%
len(dir1_paths) + len(dir2_paths) + len(dir3_paths)

#%%
