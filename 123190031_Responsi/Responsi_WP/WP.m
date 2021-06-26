%data diambil/import dari excel 
data = readtable('Real estate valuation data set.xlsx'); 

%mengambil data dari excel dan konversikan ke array
data = [data(1:50,3) data(1:50,4) data(1:50,5) data(1:50,8)]
x = table2array(data)

k = [0,0,1,0];%nilai atribut, 0(cost) dan 1(benefit)
w = [3,5,4,1];%bobot

%tahapan pertama, perbaikan bobot
[m n]=size (x); %inisialisasi ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total seluruh bobot

%tahapan kedua, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

%tahapan ketiga, proses perangkingan
V = S/sum(S);
%kemudian kita mencari index alternatif tertinggi
hasil=max(V);
disp(hasil)
alternatif=find(V == hasil)

