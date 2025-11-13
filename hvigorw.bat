@echo off
rem Copyright (c) 2023 Huawei Device Co., Ltd.
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.

setlocal enabledelayedexpansion

set HVIGOR_APP_HOME=%~dp0
set HVIGOR_WRAPPER_SCRIPT=%HVIGOR_APP_HOME%hvigorw.bat
set HVIGOR_BIN_DIR=%HVIGOR_APP_HOME%hvigor\bin
set HVIGOR_WRAPPER_JAR=%HVIGOR_BIN_DIR%\hvigor-wrapper.jar
set HVIGOR_PNPM_SCRIPT_PATH=%HVIGOR_BIN_DIR%\pnpm

if not exist "%HVIGOR_WRAPPER_JAR%" (
    echo Hvigor Wrapper jar not found at %HVIGOR_WRAPPER_JAR%
    echo Please check your installation.
    exit /b 1
)

rem Find Node.js
set NODE_EXE=node.exe
where /q %NODE_EXE%
if %ERRORLEVEL% neq 0 (
    echo Node.js not found in PATH. Please install Node.js.
    exit /b 1
)

rem Execute hvigor
%NODE_EXE% "%HVIGOR_BIN_DIR%\hvigor.js" %*
