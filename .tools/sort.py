# List all files in /build/build/partial
import os


partial_path = "/build/build/partial"
try:
    files = os.listdir(partial_path)
    if files:
        print("Files in /build/build/partial:")
        for file in files:
            if file.endswith(".pkg.tar.zst") or file.endswith(".sig"):
                if file.startswith("mcds-keyring-"):
                    if file.endswith(".sig"):
                        os.rename(
                            os.path.join(partial_path, file),
                            os.path.join(partial_path, "mcds-keyring.pkg.tar.zst.sig"),
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst.sig')} /build/public/arch/any/"
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst.sig')} /build/public/arch/x86_64/"
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst.sig')} /build/public/arch/aarch64/"
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst.sig')} /build/public/arch/armv7/"
                        )
                    else:
                        os.rename(
                            os.path.join(partial_path, file),
                            os.path.join(partial_path, "mcds-keyring.pkg.tar.zst"),
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst')} /build/public/arch/any/"
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst')} /build/public/arch/x86_64/"
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst')} /build/public/arch/aarch64/"
                        )
                        os.system(
                            f"cp {os.path.join(partial_path, 'mcds-keyring.pkg.tar.zst')} /build/public/arch/armv7/"
                        )
                # if file is for platforms x86_64, aarch64, armv7, or any
                if "-any." in file:
                    # copy file to /build/public/arch/any/
                    os.system(
                        f"cp {os.path.join(partial_path, file)} /build/public/arch/any/"
                    )
                    os.system(
                        f"cp {os.path.join(partial_path, file)} /build/public/arch/x86_64/"
                    )
                    os.system(
                        f"cp {os.path.join(partial_path, file)} /build/public/arch/aarch64/"
                    )
                    os.system(
                        f"cp {os.path.join(partial_path, file)} /build/public/arch/armv7/"
                    )
                elif "-x86_64." in file:
                    # copy file to /build/public/arch/x86_64/
                    os.system(
                        f"cp {os.path.join(partial_path, file)} /build/public/arch/x86_64/"
                    )
                elif "-aarch64." in file:
                    # copy file to /build/public/arch/aarch64/
                    os.system(
                        f"cp {os.path.join(partial_path, file)} /build/public/arch/aarch64/"
                    )
                elif "-armv7." in file:
                    # copy file to /build/public/arch/armv7/
                    os.system(
                        f"cp {os.path.join(partial_path, file)} /build/public/arch/armv7/"
                    )
    else:
        print("No files found in /build/build/partial.")
except FileNotFoundError:
    print("/build/build/partial does not exist.")
except Exception as e:
    print(f"An error occurred: {e}")
