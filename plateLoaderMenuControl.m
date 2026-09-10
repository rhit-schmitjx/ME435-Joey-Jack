function plateLoaderMenuControl(s)
while(1)
    switch(menu('Choose command','Reset','X-Axis',...
            'Z-Axis','Gripper','Move','Status','Special Moves','Exit'))
        case 1
            writeline(s,'RESET');
            readline(s)
        case 2
            writeline(s,['X-AXIS ',num2str(menu('Choose location to move to','1','2','3','4','5'))]);
            readline(s)
        case 3
            switch(menu('Z-AXIS:','EXTEND','RETRACT'))
                case 1
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                case 2
                    writeline(s,'Z-AXIS RETRACT');
                    readline(s)
            end
        case 4
            switch(menu('GRIPPER:','OPEN','CLOSE'))
                case 1
                    writeline(s,'GRIPPER OPEN');
                    readline(s)
                case 2
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
            end
        case 5
            fromLoc = menu('Location to pick up from', '1', '2', '3', '4', '5');
            toLoc   = menu('Location to move to',      '1', '2', '3', '4', '5');
            writeline(s, sprintf('MOVE %d %d', fromLoc, toLoc));
            readline(s)
        case 6
             writeline(s,'LOADER_STATUS')
             statusResponse = readline(s); % Waits for the robot's reply
             disp(statusResponse);
        case 7
            switch(menu('SPECIAL MOVES:','2 FORWARD 1 BACK','SNAKE'))
                case 1
                    uiwait(helpdlg('Please place a plate at location 1'));
                    writeline(s,'GRIPPER OPEN');
                    readline(s)
                    writeline(s,'X-AXIS 1');
                    readline(s)

                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 3');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)
                    writeline(s,'Z-AXIS RETRACT');
                    readline(s)

                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 2');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)
                    writeline(s,'Z-AXIS RETRACT');
                    readline(s)

                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 4');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)
                    writeline(s,'Z-AXIS RETRACT');
                    readline(s)

                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 3');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)
                    writeline(s,'Z-AXIS RETRACT');
                    readline(s)

                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 5');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)
                    writeline(s,'Z-AXIS RETRACT');
                    readline(s)
                case 2
                    uiwait(helpdlg('Please place a plate at locations 1 and 2'));
                    writeline(s,'X-AXIS 2');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)

                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 3');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)

                    writeline(s,'X-AXIS 1');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 2');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)

                    writeline(s,'X-AXIS 3');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 4');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)

                    writeline(s,'X-AXIS 2');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    writeline(s,'X-AXIS 3');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)

                    writeline(s,'X-AXIS 4');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 5');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)

                    writeline(s,'X-AXIS 3');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER CLOSE');
                    readline(s)
                    writeline(s,'X-AXIS 4');
                    readline(s)
                    writeline(s,'Z-AXIS EXTEND');
                    readline(s)
                    writeline(s,'GRIPPER OPEN');
                    readline(s)

                    writeline(s,'X-AXIS 5');
                    readline(s)
            end
        case 8
            break;
            
    end
end