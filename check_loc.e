start_check_location    mult        dump                width_square    four
                        blt         board_four          x               dump
                        mult        dump                width_square    six
                        blt         board_six           x               dump
                        mult        dump                width_square    seven
                        blt         board_seven         x               dump
                        cp          location_x          eight         
check_location_endx     be          start_check_y       zero            zero
board_four              mult        dump                width_square    two
                        blt         board_two           x               dump
                        mult        dump                width_square    three
                        blt         board_three         x               dump
                        cp          location_x          four
                        be          check_location_endx zero            zero
board_six               mult        dump                width_square    five
                        blt         board_five          x               dump
                        cp          location_x          six
                        be          check_location_endx zero            zero
board_seven             cp          location_x          seven
                        be          check_location_endx zero            zero
board_two               blt         board_one           x               width_square
                        cp          location_x          two
                        be          check_location_endx zero            zero
board_three             cp          location_x          three
                        be          check_location_endx zero            zero
board_one               cp          location_x          one
                        be          check_location_endx zero            zero
board_five              cp          location_x          five
                        be          check_location_endx zero            zero