# Requirements

```bash
# zephyr sdk
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.16.4/zephyr-sdk-0.16.4_macos-aarch64.tar.xz
tar xvf zephyr-sdk-0.16.4_macos-aarch64.tar.xz -C ~/.local/zephyr-sdk
cd ~/.local/zephyr-sdk
./setup.sh

# zephyr
pip install west
west init ~/zephyrproject
west update
west zephyr-export

# this app
./build.sh
```
