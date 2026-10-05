classdef PlateLoader < hgsetget
    %PLATELOADER Controls the Beckman Coulter Plate Loader Robot
    %   Performs the basic actions to control the plate loader

    properties
        piAddress
        serialRobot
        xAxisPosition
        isZAxisExtended
        isGripperClosed
        isPlatePresent
    end
    properties (Constant = true)
        defaultTimeTable = [0 60 20 30 0
            0 0 30 30 0
            0 30 0 30 0
            0 30 30 0 0
            0 30 20 60 0];
    end

    methods (Access = private)
        function response = sendCommand(obj, command)
            import matlab.net.*
            import matlab.net.http.*
    
            r = RequestMessage;
            uri = URI("http://" + obj.piAddress + ":8080/api/" + command);
            
            resp = send(r, uri);
            response = resp.Body.Data;
            
            fprintf("Response to %s --> %s\n", command, response);
        end
    end

    methods
        function obj = PlateLoader(piIP)
            % Construct a PlateLoader Object
            obj.piAddress = piIP;
            obj.xAxisPosition = 3;
            obj.isZAxisExtended = false;
            obj.isGripperClosed = true;
            obj.isPlatePresent = false;
        end

        function response = reset(obj)
            % Reset robot
            response = obj.sendCommand("RESET");
            obj.xAxisPosition = 3;
            obj.isZAxisExtended = false;
            obj.isGripperClosed = true;
        end
        function response = x(obj,pos)
            % Moves the x-axis to position, passes the reply back to caller
            if (pos <1 || pos>5)
                fprintf('Illegal position\n');
                return
            end
            response = obj.sendCommand("X-AXIS " + pos);
            if(obj.xAxisPosition ~= pos)
                obj.isZAxisExtended = false;
            end
            obj.xAxisPosition = pos;
        end
        function response = extend(obj)
            response = obj.sendCommand("Z-AXIS EXTEND");
            if startsWith(response, "ERROR")
                obj.isZAxisExtended = false;
            else
                obj.isZAxisExtended = true;
            end
        end
        function response = retract(obj)
            % Retracts the Z-Axis, passes the reply back to caller
            response = obj.sendCommand("Z-AXIS RETRACT");
            obj.isZAxisExtended = false;
        end
        function response = close(obj)
            % Close Gripper, passes the reply back to caller
            response = obj.sendCommand("GRIPPER CLOSE");
            obj.isGripperClosed = true;
            if endsWith(response, "NOPLATE")
                obj.isPlatePresent = false;
            else
                obj.isPlatePresent = true;
            end
        end
        function response = open(obj)
            % Open Gripper, passes the reply back to caller
            response = obj.sendCommand("GRIPPER OPEN");
            obj.isGripperClosed = false;
            obj.isPlatePresent = false;
        end
        function response = movePlate(obj, startPos, endPos)
            if (startPos <1 || startPos>5 || endPos <1 || endPos>5)
                fprintf('Illegal position\n');
                return
            end
            response = obj.sendCommand("MOVE " + startPos + " " + endPos);
            if startsWith(response, "ERROR")
                obj.xAxisPosition = startPos;
                obj.isZAxisExtended = false;
                obj.isGripperClosed = false;
                obj.isPlatePresent = false;
            else
                obj.xAxisPosition = 3;
                obj.isZAxisExtended = false;
                obj.isGripperClosed = true;
                obj.isPlatePresent = false;
            end
        end
        function response = setTimeValues(obj,timeDelays)
            % setTimeValues(timeDelays) - Passes a matrix with 5 rows (froms)
            % and 5 columns (tos) to set all the time delay value
            if (size(timeDelays) ~= [5 5])
                fprintf('Need a 5 by 5 matrix of time delays\n');
                return
            end
            for i = 1:5
                for j = 2:4
                    if(i ~= j)
                        timeCommand = sprintf('SET_DELAY %d %d %d', i,j,timeDelays(i,j));
                        response = obj.sendCommand(timeCommand);
                        fprintf('%s\n', response);
                    end
                end
            end
        end
        function response = resetDefaultTimes(obj)
            % Resets the default time delay table values
            response = obj.setTimeValues(obj.defaultTimeTable);
        end
        function response = getStatus(obj)
            % Since we are keeping the status as instance fields we can just
            % get the properties of the class, this is a useful double check
            % TODO: Make the values update if different
            %  Can someone make the call to LOADED_STATUS also update
            %  properties, just in case somehow it gets off
            response = obj.sendCommand("LOADER_STATUS");
        end

        % Other to todo's if someone wants to.  Implement the additional
        %  weird commands: STOP_CYLINDER, VERSION,
        %  X-AXIS_STATUS, Z-AXIS_STATUS, GRIPPER_STATUS

        function [xPos,zAxis,grip,plate] = getProperties(obj)
            % Returns the status properties of the robot (for GUI display)
            xPos = obj.xAxisPosition;
            zAxis = obj.isZAxisExtended;
            grip = obj.isGripperClosed;
            plate = obj.isPlatePresent;
        end
        function response = shutdown(obj)
            % Close serial object
            obj.piAddress = '';
            response = 'Disconnected';
        end
        function disp(obj)
            % Overrides the display when seeing robot status
            % Note: if you need to see the field names use
            %    get(_objectName_)
            fprintf('  X-AXIS %d, ',obj.xAxisPosition);
            if (obj.isZAxisExtended)
                fprintf('EXTENDED, ');
            else
                fprintf('RETRACTED, ');
            end
            if (obj.isGripperClosed)
                if( obj.isPlatePresent )
                    fprintf('CLOSED, PLATE');
                else
                    fprintf('CLOSED, NOPLATE');
                end
            else
                fprintf('OPEN');
            end
            fprintf('\n');
        end
    end
end
