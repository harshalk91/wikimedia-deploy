#echo "Enter number of replicas:"
echo "Enter Replica Count:"
read count

sudo kubectl scale --replicas=$count deployment/wkmedia

while [ $count != `sudo kubectl get deployment | grep wkmedia | awk '{print $4}'` ]
do 
	echo "Current Available Replicas: `sudo kubectl get deployment | grep wkmedia | awk '{print $4}'`"
        sleep 5
done

#sleep 10
sudo kubectl get pods | grep wkmedia | grep -i running | awk '{print $1}' > wkmedia_pods

while read line
do
    echo "Copying to LocalSettings.php to $line"
    sudo kubectl cp LocalSettings.php $line:/var/www/mediawiki/LocalSettings.php
done < wkmedia_pods 
