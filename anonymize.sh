list1=$(tail -n +2 mean_welch_in_networks_FWHM_5.csv | cut -f1 -d, | sort | uniq)
list2=$(tail -n +2 sucrose_master_data_FWHM_5_final_networkremoved.csv | cut -f1 -d, | sort | uniq)
fulllist=$(echo "$list1\n$list2" | sort | uniq)
newlist=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 10 | head -n 120 | sort | uniq)
pairedlist=$(paste -d, <(echo $fulllist) <(echo $newlist))
while IFS= read -r line; do
  target=$(echo $line | cut -f1 -d,)
  replacement=$(echo $line | cut -f2 -d,)
  # echo "target is ${target} and replacement is ${replacement}"
  sed -i "s/$target/$replacement/g" *.csv
done <<<$pairedlist
