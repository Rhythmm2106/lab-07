
#!/bin/bash

for i in 1 2 3 4
do
    rm -rf Testcase${i}Diff

    for file in Testcase${i}/*.1.txt
    do
        file2="${file%.1.txt}.2.txt"

        if [ -f "$file2" ]
        then
            if ! diff -q "$file" "$file2" > /dev/null
            then
                mkdir -p Testcase${i}Diff

                name=$(basename "$file")
                name="${name%.1.txt}"

                diff -u "$file" "$file2" > "Testcase${i}Diff/${name}Diff.txt"
            fi
        fi
    done
done
