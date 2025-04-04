package main

import (
	"fmt"
	"os"
	"strings"
	"time"
)

func main() {
	                              this_file := "ACH.csv"
	file_data, err := os.ReadFile(this_file)
	if err != nil {
		fmt.Println("Error reading file:", err)
		return
	}
	            				                  file_Str := string(file_data)
				cleaned_Str := strings.ReplaceAll(file_Str, "_", " ")
	aa     := strings.Split(cleaned_Str, "\n")

	var new_Str = ""
                        total_nbr_lines := len(aa) - 1
	for ii := 1 ; ii <= total_nbr_lines ; ii++ {

					this_Line := aa[ii]
	    fmt.Println(this_Line)		   
        
		if ii < total_nbr_lines { new_Str += this_Line + "\n"
		} else {                  new_Str += this_Line
		}
	} 

	cleaned_Bytes := []byte(new_Str)

						  		     now := time.Now()
						  today_F := now.Format("2006_01_02")
	ach_today := "ACH_" + today_F

	   err3 := os.WriteFile(ach_today, cleaned_Bytes, 0644)
	if err3 != nil {
		fmt.Println("Error writing to file:", err3)
		return
	}
}