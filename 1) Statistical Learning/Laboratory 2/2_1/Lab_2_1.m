data=load('heightWeight.mat')


male=data.heightWeightData(data.heightWeightData(:,1)==1,2:end);
female=data.heightWeightData(data.heightWeightData(:,1)==2,2:end);

figure(1)
hold on

scatter(male(:,1),male(:,2),'^b')
scatter(female(:,1),female(:,2),'vm')

grid on
grid minor
xlabel('Height (cm)')
ylabel('Weight (kg)')
legend('Males','Females','location','northwest')
xlim([120 220])
ylim([30 130])
axis equal

figure(2)
hold on
edges=130:5:220;
h1=histcounts(male(:,1),edges);
h2=histcounts(female(:,1),edges);
b = bar(edges(1:end-1),[h1;h2]',1);
b(1).FaceColor = 'b';
b(2).FaceColor = 'm';
xlabel('Height (cm)');
ylabel('Number of People');
grid on;
grid minor;
legend('Males','Females','location','northwest');


figure(3)
hold on
edges=30:5:130;
h1=histcounts(male(:,2),edges);
h2=histcounts(female(:,2),edges);
b = bar(edges(1:end-1),[h1;h2]',1);
b(1).FaceColor = 'b';
b(2).FaceColor = 'm';
xlabel('Weight (kg)');
ylabel('Number of People');
grid on;
grid minor;
legend('Male','Female','location','northwest');


length(male)
mean_m = 0;
for i = 1:length(male)
    mean_m = mean_m + male(i,:);
end
mean_m = mean_m/length(male)

mean_f = 0;
for i = 1:length(female)
    mean_f = mean_f + female(i,:);
end
mean_f = mean_f/length(female)


firstTerm = zeros(2);  % 2x2 matrix of zeros
for i = 1:length(male)
    firstTerm = firstTerm + male(i,:)'*male(i,:); 
end
firstTerm = firstTerm/length(male);
secondTerm = mean_m.*mean_m';
cov_m = firstTerm - secondTerm

firstTerm = zeros(2);  % 2x2 matrix of zeros
for i = 1:length(female)
    firstTerm = firstTerm + female(i,:)'*female(i,:); 
end
firstTerm = firstTerm/length(female);
secondTerm = mean_f.*mean_f';
cov_f = firstTerm - secondTerm


figure(4)
x1 = 120:220; x2 = 30:130;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mean_m,cov_m);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([120 220 30 130 0 max(F(:))]);
xlabel('Height (cm)'); ylabel('Weight (kg)'); zlabel('Probability Density - males');
title('Males');
view(0,90); axis equal; colorbar;

figure(5)
x1 = 120:1:220; x2 = 30:1:130;
[X1,X2] = meshgrid(x1,x2);
F = mvnpdf([X1(:) X2(:)],mean_f,cov_f);
F = reshape(F,length(x2),length(x1));
surf(x1,x2,F);
caxis([min(F(:))-.5*range(F(:)),max(F(:))]);
axis([120 220 30 130 0 max(F(:))])
xlabel('Height (cm)'); ylabel('Weight (kg)'); zlabel('Probability Density - females');
view(0,90); axis equal; colorbar;
