#!/usr/bin/bash                                                                           
# Load any and all Markdown files and tlinks                                              
md_files=$(ls *.md)                                                                       
# Process each markdown file                                                              
echo 'Extracting urls from:'                                                              
for file in "${md_files[@]}"; do                                                          
  echo "$file"                                                                          
  contents=`cat $file`                                                                  
  # Extract URLs from markdown links                                                    
  urls=$(grep -oP '!?\[[^\]]*\]\(\Khttps?://[^\s)]+' <<< ${contents})                   
  urls+=$'\n'                                                                           
done                                                                                      

echo -e "Urls to be tested:\n${urls}"                                                     
echo '---'                                                                                
# Iterate through list urls                                                               
for item in "${urls[@]}"; do                                                              
  echo "Testing: ${item}"                                                                 
  until curl -sI ${item}  >> link_test_results.txt                                        
  do                                                                                      
    sleep 5
  done                                                                                    
done   
