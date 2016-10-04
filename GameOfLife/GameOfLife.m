classdef GameOfLife < handle
   properties
      grid_matrix
      side_length
      display
   end
   methods
        function obj = GameOfLife(length)
            obj.grid_matrix = zeros(length,length);
            obj.side_length = length;
        end
        
        function obj = RandomPopulate(obj)
            obj.grid_matrix = randi([0 1],obj.side_length,obj.side_length);
            
        end
        
      function obj = DisplayGrid(obj, current_step)
          if(nargin < 2)
              imshow(obj.grid_matrix);
          else
            if(isempty(obj.display))
                
                obj.display = figure('Name',strcat('Current Step: ',num2str(current_step)));
                obj.display,imshow(obj.grid_matrix,'Border','tight','InitialMagnification',200);
              
            else
                obj.display.Name = strcat('Current Step: ',num2str(current_step));
                obj.display,imshow(obj.grid_matrix,'Border','tight','InitialMagnification',200);  
            end
            
          end
      end
      
      function obj = UpdateGrid(obj)
         
%          base_array = 1:obj.side_length;
%          n_array = repelem(base_array,obj.side_length);
%          m_array =  repmat(base_array,1,obj.side_length);
%          for k = 1:(obj.side_length*obj.side_length)
%            obj_array(k) = obj;
%         end
%         new_values = arrayfun(@obj.CheckSquare,obj_array,n_array,m_array);
%          
         new_values = zeros(obj.side_length,obj.side_length);
         for n_cord = 1:obj.side_length
             for m_cord = 1:obj.side_length
                new_values(n_cord,m_cord) = obj.CheckSquare(obj,n_cord,m_cord);
             end
         end
         obj.grid_matrix = reshape(new_values,obj.side_length,obj.side_length)';
         
         obj = obj;
      end
      
      function obj = LifeSteps(obj,steps)
        
        if(steps>0)
          
          for step = 1:steps
            obj.UpdateGrid();
            obj.DisplayGrid(step);
            if(sum(reshape(obj.grid_matrix,1,(obj.side_length*obj.side_length))) == 0)
                h = msgbox(strcat('The game has ended after. Number of steps: ',num2str(step)));
                break
            end
               
          end
          
        end
      end
 
          
   end
  
    methods(Static)
        function square_value = CheckSquare(obj,n,m)

            N = obj.side_length;
            M = obj.side_length;

   
            
            neighbours = obj.grid_matrix(max((n-1), 1):min((n+1), end), max((m-1),1):min((m+1),end));
            
    
            neighbours=reshape(neighbours,1,numel(neighbours));
            
            neighbour_total = sum(neighbours);
            neighbour_total = neighbour_total - obj.grid_matrix(n,m);
            square_value = 0;

            current_state = obj.grid_matrix(n,m);
            if(current_state)
                if(neighbour_total < 2 || neighbour_total > 3)
                    square_value = 0; 
                else
                    square_value = 1;
                end
            else
                if(neighbour_total == 3)
                   square_value = 1; 
                end
            end

        end   

    end
   
  
   
   
end