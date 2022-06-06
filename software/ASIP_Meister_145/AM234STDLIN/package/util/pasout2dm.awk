###############################################################################
# convert data section code in .out to memory image for brownie32-gcc
#                                             Written by Hirofumi IWATO 2008
#                              All Rights Reserved 2008. ASIP Solutions, Inc.
###############################################################################
# to convert 0x- string to integer
function atox(str){
  len = length(str);
  sum = 0;

  for(i=1; i<=len; i++){
    sum = sum * 16;

    c = substr(str, i,1);

    if(c == "0") sum += 0;
    else if(c == "1") sum += 1;
    else if(c == "2") sum += 2;
    else if(c == "3") sum += 3;
    else if(c == "4") sum += 4;
    else if(c == "5") sum += 5;
    else if(c == "6") sum += 6;
    else if(c == "7") sum += 7;
    else if(c == "8") sum += 8;
    else if(c == "9") sum += 9;
    else if(c == "a") sum += 10;
    else if(c == "b") sum += 11;
    else if(c == "c") sum += 12;
    else if(c == "d") sum += 13;
    else if(c == "e") sum += 14;
    else if(c == "f") sum += 15;
    else print "fatal error occured in atox";
  }

  return sum;
}


function atoi(str){
  len = length(str);
  sum = 0;

  for(i=1; i<=len; i++){
    sum = sum * 10;

    c = substr(str, i,1);

    if(c == "0") sum += 0;
    else if(c == "1") sum += 1;
    else if(c == "2") sum += 2;
    else if(c == "3") sum += 3;
    else if(c == "4") sum += 4;
    else if(c == "5") sum += 5;
    else if(c == "6") sum += 6;
    else if(c == "7") sum += 7;
    else if(c == "8") sum += 8;
    else if(c == "9") sum += 9;
    else print "fatal error occured in atox";
  }

  return sum;
}

###############################################################################
BEGIN {
  addr_space  = 4; # 4 bytes
# endian      = 1; # always big
  in_section  = 0;
}


###############################################################################
/^[[:digit:]]+.*\.section/ {
  if($3 ~ /^.text$/){
    in_section = 0;
  }
  if($3 !~ /^.text$/){
    in_section = 1;
  }
}


###############################################################################
/^[[:digit:]]+[\t\s]+[[:xdigit:]]{4}[\t\s]+/ {

  if(in_section){
#    print $1 " " $2 " " $3 " " $4; # for debugging

    base_addr = atox($2);

    split($4, data_type, ".");
    data_w = atoi(data_type[3]) / 8; # in byte

    for(i=0; i<data_w; ++i){
      printf("%08x %s\n", base_addr+i, substr($3, 1+i*2, 2));
    }

  }
}

###############################################################################
END{
  # finish up remainder of the final data

}
