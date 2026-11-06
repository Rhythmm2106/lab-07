
#!/bin/bash

overall=0

for i in 1 2 3 4
do
    correct=1

    for file in Testcase${i}/*.1.txt
    do
        file2="${file%.1.txt}.2.txt"

        if [ -f "$file2" ]
        then
            name=$(basename "$file")
            name="${name%.1.txt}"

            output="Testcase${i}Diff/${name}Diff.txt"

            if diff -q "$file" "$file2" > /dev/null
            then
                if [ -f "$output" ]
                then
                    correct=0
                fi
            else
                if [ ! -f "$output" ]
                then
                    correct=0
                else
                    if ! diff -u "$file" "$file2" | tail -n +3 | diff -u <(tail -n +3 "$output") -
                    then
                        correct=0
                    fi
                fi
            fi
        fi
    done

    if [ "$correct" -eq 1 ]
    then
        if [ -d "Testcase${i}Diff" ]
        then
            if [ -z "$(ls -A "Testcase${i}Diff")" ]
            then
                correct=0
            fi
        else
            for file in Testcase${i}/*.1.txt
            do
                file2="${file%.1.txt}.2.txt"

                if [ -f "$file2" ] && ! diff -q "$file" "$file2" > /dev/null
                then
                    correct=0
                fi
            done
        fi
    fi

    if [ "$correct" -eq 1 ]
    then
        echo "Testcase${i}: PASS"
    else
        echo "Testcase${i}: FAIL"
        overall=1
    fi
done

exit "$overall"
