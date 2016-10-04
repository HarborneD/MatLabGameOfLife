
a = GameOfLife(200);

%a.grid_matrix(:,50:55) = 1;

a.RandomPopulate();

a.LifeSteps(5000);