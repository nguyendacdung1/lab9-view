create database Books
go
use Books
go
create table Customer
(    
     CustomerID int primary key,
	 CustomerName nvarchar(100),
	 Address nvarchar(200),
	 Phone varchar(12)
)
go
create table Book
(
     BookID int primary key,
	 Category nvarchar(50),--loại sách
	 Author nvarchar(100),--tên tác giả
	 Publisher nvarchar(100),--Tên nhà xuất bản
	 Title nvarchar(100), --tiêu đề sách
	 Price int, --giá sách
	 InStore int --số sách hiện có
)
go
create table BookSold --sách đã bán
(
     BookSoldID int primary key,
	 CustomerID int foreign key references Customer(CustomerID),
	 BookID int foreign key references Book(BookID),
	 Date datetime, --ngày bán
	 Price int, --Giá thời điểm bán
	 Amount int --Số sách bán
)
go
insert into Customer values(1,N'Đỗ Thu Trang',N'Tân Dân','0964120026'),
                           (2,N'Nguyễn Đắc Dũng',N'Hưng Yên','0585009531'),
                           (3,N'Võ Huy Hoàng',N'Hưng Yên','0525387239'),
						   (4,N'Lê Hải Thịnh',N'Tân Dân','0233532567'),
						   (5,N'Phạm Thị Trang',N'Tân Dân','0143653316')
go
insert into Book values(520, N'Tiểu Thuyết',N'Cổ Ngạn',N'Hoa Hướng Dương',N'Anh Không Thích Thế Giới Này Anh Chỉ Thích Em',520000,100),
                       (12, N'Kinh Tế',N'TS.Nguyễn Như Ý',N'NSB Kinh Tế',N'Kinh Tế Vĩ Mô',200000,24),
					   (03, N'Truyện', N'Fuji',N'Kim Đồng',N'Đom Đóm',30000,20),
					   (203, N'Tiểu Thuyết',N'Suns',N'Mon',N'Người Trong Đêm',100000,30),
					   (666, N'Tiểu Thuyết',N'X',N'Mon',N'Đêm Máu',99000,6)
go
insert into BookSold values(01,1,520,'2022-01-06', 520000,1),
                           (02,1,12,'2022-01-06',150000,1),
						   (03,2,520,'2022-01-06',520000,1),
						   (04,2,03,'2022-01-06',30000,2),
						   (05,4,666,'2021-11-24',100000,1),
						   (06,4,203,'2021-11-20',100000,1),
						   (07,5,03,'2021-11-20', 40000,4),
						   (08,5,12,'2021-11-20',200000,1),
						   (09,5,520,'2021-11-20',520000,1),
						   (10,3,03,'2020-10-19',40000,5)
go

/*tạo khung nhìn chứa danh sách các cuốn sách
(BookCode, Title, Price) kèm theo số lượng đã
bán được của mỗi cuốn sách.*/
create view DS_Book AS
select Book.BookID,Book.Title,Book.Price,BookSold.Amount
from Book
inner join BookSold
on Book.BookID=BookSold.BookID

select*from DS_Book


/*Tạo một khung nhìn chứa danh sách các khách hàng
(CustomerID, CustomerName, Address) kèm
theo số lượng các cuốn sách mà khách hàng đó đã mua.*/
create view DS_Customer AS
select Customer.CustomerID, Customer.CustomerName, Customer.Address, BookSold.Amount
from Customer
inner join BookSold
on Customer.CustomerID=BookSold.CustomerID

select*from DS_Customer
						   
/*Tạo một khung nhìn chứa danh sách các khách hàng 
(CustomerID, CustomerName, Address) đã
mua sách vào tháng trước, kèm theo tên các cuốn 
sách mà khách hàng đã mua.*/
