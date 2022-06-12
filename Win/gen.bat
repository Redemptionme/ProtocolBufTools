@echo off
cd /d %~dp0

::协议文件路径, 最后不要跟“\”符号
set SOURCE_FOLDER=..\..\Message\ProtoDefine

::C#编译器路径
set CS_COMPILER_PATH=.\protoc.exe
::C#文件生成路径, 最后不要跟“\”符号
set CS_TARGET_PATH=.\out

set PROJECT_CS_TARGET_PATH=..\..\Message\ProtoCs


echo %SOURCE_FOLDER%
echo %CS_COMPILER_PATH%
echo %CS_TARGET_PATH%
echo %PROJECT_CS_TARGET_PATH%


if exist %CS_TARGET_PATH% (  
	::删除之前创建的文件
	del %CS_TARGET_PATH%\*.* /f /s /q
	del /f /s /q %CS_TARGET_PATH%\*.*     
) else (  
	rem 创建d:\MIS\OracleDBAutoBackup   
	echo createFold%CS_TARGET_PATH%  
	md %CS_TARGET_PATH%  
)  
  
::遍历所有文件 这里没做嵌套遍历!!!!!!!!! bat太难写了,后面考虑改python吧
for /f "delims=" %%i in ('dir /b "%SOURCE_FOLDER%\*.proto"') do (    
    ::生成 C# 代码
    call %CS_COMPILER_PATH% --proto_path=%SOURCE_FOLDER% --csharp_out=%CS_TARGET_PATH% %%i    
)

:: 覆盖复制，即默认覆盖同名文件，如果需要提示后覆盖的话，把命令的/y去掉即可。
xcopy /s /i /y %CS_TARGET_PATH%  %PROJECT_CS_TARGET_PATH%

echo csharp complete!

del %CS_TARGET_PATH%\*.* /f /s /q
del /f /s /q %CS_TARGET_PATH%\*.*

pause