#!/bin/bash
# 禁用 Yarn 的严格模式
export YARN_ENABLE_IMMUTABLE_INSTALLS=false

# 安装依赖
yarn install

# 构建站点
yarn build 