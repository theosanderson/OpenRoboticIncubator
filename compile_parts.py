import os
dir = "./parts"
# list all directories immediately inside the parts directory
subdirs = [d for d in os.listdir(dir) if os.path.isdir(os.path.join(dir, d))]
for subdir in subdirs:
    print("Compiling " + subdir)
    # list files in subdir
    the_path = os.path.join(dir, subdir)
    files = [f for f in os.listdir(the_path) if os.path.isfile(os.path.join(the_path, f))]
    # make a subdir within this subdir called "stl"
    stl_dir = the_path + "/stl"
    if not os.path.exists(stl_dir):
        os.makedirs(stl_dir)
    # delete everything in stl_dir
    for file in os.listdir(stl_dir):
        os.remove(stl_dir + "/" + file)
    # compile all files in subdir
    for file in files:
        print(file)
        # if the file contents contains "select"
        if "select" in open(the_path + "/" + file).read():
            for i in range(10):
                print(i)
                os.system("openscad -o " + stl_dir + "/" + file + "_" + str(i) + ".stl " + the_path + "/" + file + " -D modules=[" + str(i) + "]")
        else:
            os.system("openscad -o " + stl_dir + "/" + file + ".stl " + the_path + "/" + file)

