#!/bin/bash
#web环境部署

read -p "application dir:" dir
[ -d "$dir" ] || mkdir "$dir"
if [ ! -d "$dir" ];then
    echo -e "\033[31m the application dir is fail! \033[0m"
    exit 2
fi
/bin/cp -fr ./php ${dir}
/bin/cp -fr ./nginx ${dir}
/bin/cp -fr ./mysql ${dir}
/bin/cp -fr ./redis ${dir}
/bin/cp -fr ./run ${dir}

echo -e "\033[32m install success! \033[0m"
exit 0