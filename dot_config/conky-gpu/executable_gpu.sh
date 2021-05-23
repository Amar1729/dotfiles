#! /bin/bash

# various gpu measurements for conky

current_perf () {
    # return the current perf level
    nvidia-settings -q '[gpu:0]/GPUCurrentPerfLevel' -t
}

perf_str () {
    # return the settings string for the current perf level
    nvidia-settings -q '[gpu:0]/GPUPerfModes' -t \
        | grep -o "perf=$1[^;]*" \
        | tr ',' '\n'
}

gpu_freq () {
    # get GPU frequency and scale to 0-100 based on max

    perf=$(current_perf)
    output="$(perf_str $perf)"

    curr=$(grep 'nvclock=' <<< $output | grep -o '[0-9]*')
    min=$(grep 'nvclockmin=' <<< $output | grep -o '[0-9]*')
    max=$(grep 'nvclockmax=' <<< $output | grep -o '[0-9]*')

    echo -e "$perf \n $curr \n $min \n $max"
}

graph () {
    # 0-100 - corrected scale for gpu frequency
    nums=($(gpu_freq))

    # uncorrected (slightly prettier visually, but is this less accurate?
    echo "100 * ${nums[1]} / ${nums[3]}" \
        | bc -l

    # corrected
    # echo "100 * ( ${nums[1]} - ${nums[2]} ) / ( ${nums[3]} - ${nums[2]} )" \
    #     | bc -l
}

temp () {
    # 0-100 - corrected scale for gpu frequency

    curr=$(nvidia-settings -q '[gpu:0]/GPUCoreTemp' -t)
    max=$(nvidia-settings -q '[gpu:0]/GPUMaxOperatingTempThreshold' -t)

    echo "100 * $curr / $max" | bc -l
}

mem () {
    perf=$(current_perf)

    case $perf in
        0) echo   5 ;;
        1) echo  25 ;;
        2) echo  50 ;;
        3) echo  75 ;;
        4) echo 100 ;;
    esac
}

display () {
    # get a string to display in the counter
    nums=($(gpu_freq))

    echo "${nums[0]}: ${nums[1]} / ${nums[3]}"
}

if [[ "$1" == "--graph" ]]; then
    graph
elif [[ "$1" == "--temp" ]]; then
    temp
elif [[ "$1" == "--mem" ]]; then
    mem
else
    display
fi
