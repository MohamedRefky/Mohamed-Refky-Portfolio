@echo off
echo ========================================================
echo   Building Mohamed Refky Portfolio for Web (Release)
echo   With --no-tree-shake-icons to preserve all icons
echo ========================================================
flutter.bat build web --release --no-tree-shake-icons
echo.
echo ========================================================
echo   Build finished successfully!
echo   You can now commit build/web and push to GitHub:
echo     git add build/web
echo     git commit -m "Deploy latest build with icons"
echo     git push
echo ========================================================
pause

