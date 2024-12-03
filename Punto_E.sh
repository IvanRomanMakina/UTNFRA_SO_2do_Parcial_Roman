#Crear repositorio y subir archivos
cd "$HOME/RTA_Examen_$(date |%Y%m%d)"
git init
git add .
git commit -m "Add: Entrega de segundo parcial"
git branch -M main
git remote add origin github/IvanRomanMakina/UTNFRA_SO_2do_Parcial_Roman
git push -u origin main
