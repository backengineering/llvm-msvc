import shutil
import os
import sys

def copy_files_and_dirs(source_dir, target_dir):
    """
    Copy all files and directories from the source directory to the target directory.
    Existing files in the target directory will be overwritten.
    
    Args:
    - source_dir: The path to the source directory.
    - target_dir: The path to the target directory.
    """
    if not os.path.isdir(source_dir):
        print(f"The source directory does not exist: {source_dir}")
        return

    if not os.path.exists(target_dir):
        os.makedirs(target_dir, exist_ok=True)

    for item in os.listdir(source_dir):
        source_path = os.path.join(source_dir, item)
        target_path = os.path.join(target_dir, item)

        if os.path.isdir(source_path):
            # If the item is a directory, recursively copy the directory.
            shutil.copytree(source_path, target_path, dirs_exist_ok=True)
            print(f"Copied directory {source_path} to {target_path}")
        elif os.path.isfile(source_path):
            # If the item is a file, copy the file.
            shutil.copy2(source_path, target_path)
            print(f"Copied file {source_path} to {target_path}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python copy_files.py <source_directory> <target_directory>")
    else:
        source_directory = sys.argv[1]
        target_directory = sys.argv[2]
        copy_files_and_dirs(source_directory + "/bin", target_directory + "/bin")
        copy_files_and_dirs(source_directory + "/lib/clang", target_directory + "/lib/clang")
       
