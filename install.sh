#!/bin/bash
#web环境部署

read -p "application dir:" dir
[ -d "$dir" ] || mkdir "$dir"
if [ ! -d "$dir" ];then
    echo "the application dir is fail!"
    exit 2
fi
/bin/cp -fr ./php ${dir}
/bin/cp -fr ./nginx ${dir}
/bin/cp -fr ./mysql ${dir}
/bin/cp -fr ./redis ${dir}
/bin/cp -fr ./run.sh ${dir}