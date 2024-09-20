open Screen


let _ =
  print_string "Hi!";

  print_image [[false;true;false;true;false];
               [false;true;false;true;false];
               [false;false;false;false;false];
               [true;false;false;false;true];
               [false;true;true;true;false]];

  while true do
    if ButtonA.is_on ()
    then print_string "M"
    else
      print_image [[false;true;false;true;false];
               [false;true;false;true;false];
               [false;false;false;false;false];
               [true;false;false;false;true];
               [false;true;true;true;false]];
    if ButtonB.is_on ()
    then print_string "J"
    else
      print_image [[false;true;false;true;false];
               [false;true;false;true;false];
               [false;false;false;false;false];
               [true;false;false;false;true];
               [false;true;true;true;false]]
  done
