#!/bin/bash

curl https://mcdonalds.com.pk/our-menu/breakfast/ | tr '\n' ' ' | grep -o '<section class=\"kc-elm kc-css-838508 kc_row\">.*</section>' | sed 's/<\/section>.*//' | grep -oP '(?<=a href=")[^"]*' | sed 's/http:\/\//https:\/\//g' > links.txt  #Fetching html that seperates links of menu items

cat links.txt | sed -e 's#/$##' | sed -e 's|.*/||' > ids.txt  #Fetching <div = id tag 

id=()                                                       #Reading file as array to pass to grep below
while read -r ids;
do
  id+=("$ids")
done < ids.txt

counter1=0
counter2=1
while read links;
do  
    curl $links | tr '\n' ' ' | grep -o "<div id=\""${id[$counter1]}".*<div id=\""${id[$counter2]}"" | grep -oP '(?<=h2 class="woocommerce-loop-product__title">)[^<]*' | awk '{print NR  ". " $s}' > ${id[$counter1]}.txt      #Running the script from <div id="breakfast" to <div id="<next menu>" and so on until end of file to grep menu items of a particular tab
    counter1=$(( $counter1 + 1 ));
    counter2=$(( $counter2 + 1 ));
done < links.txt




# echo ${id[0]}
# echo ${id[4]}

# while read links;
# do  

#     curl $links | tr '\n' ' ' | grep -o "<div id=\""$id"\".*" > $id.txt

# done < links.txt
