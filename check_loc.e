//check location
start_check_x           mult        dump                width_square    four
                        blt         board_four          select_x               dump
                        mult        dump                width_square    six
                        blt         board_six           select_x               dump
                        mult        dump                width_square    seven
                        blt         board_seven         select_x               dump
                        cp          location_x          eight         
check_location_endx     be          start_check_y       zero            zero
board_four              mult        dump                width_square    two
                        blt         board_two           select_x               dump
                        mult        dump                width_square    three
                        blt         board_three         select_x               dump
                        cp          location_x          four
                        be          check_location_endx zero            zero
board_six               mult        dump                width_square    five
                        blt         board_five          select_x               dump
                        cp          location_x          six
                        be          check_location_endx zero            zero
board_seven             cp          location_x          seven
                        be          check_location_endx zero            zero
board_two               blt         board_one           select_x               width_square
                        cp          location_x          two
                        be          check_location_endx zero            zero
board_three             cp          location_x          three
                        be          check_location_endx zero            zero
board_one               cp          location_x          one
                        be          check_location_endx zero            zero
board_five              cp          location_x          five
                        be          check_location_endx zero            zero
start_check_y           mult        dump                width_square    four
                        blt         board_four_y        select_y               dump
                        mult        dump                width_square    six
                        blt         board_six_y         select_y               dump
                        mult        dump                width_square    seven
                        blt         board_seven_y       select_y               dump
                        cp          location_y          eight         
check_location_endy     ret         retvar1
board_four_y            mult        dump                width_square    two
                        blt         board_two_y         select_y               dump
                        mult        dump                width_square    three
                        blt         board_three_y       select_y               dump
                        cp          location_y          four
                        be          check_location_endy zero            zero
board_six_y             mult        dump                width_square    five
                        blt         board_five_y        select_y               dump
                        cp          location_y          six
                        be          check_location_endy zero            zero
board_seven_y           cp          location_y          seven
                        be          check_location_endy zero            zero
board_two_y             blt         board_one_y         select_y               width_square
                        cp          location_y          two
                        be          check_location_endy zero            zero
board_three_y           cp          location_y          three
                        be          check_location_endy zero            zero
board_one_y             cp          location_y          one
                        be          check_location_endy zero            zero
board_five_y            cp          location_y          five
                        be          check_location_endy zero            zero
//end check location