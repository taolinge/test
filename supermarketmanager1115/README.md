#超市账单管理系统<br/>
本项目采用jsp+jquery+javabean+servlet+oracle进行MVC开发<br/>
1.项目基本分为账单管理、供应商管理、商品管理、用户管理四个模块。<br/>
2.采用MVC模式进行开发，前端控制器接收所有的请求，并分别向对应的模块servlet进行转发，由模块servlet进行实际的处理。<br/>
3.四个模块完成基本的增、删、改、查功能和分页显示数据。<br/>
4.供应商管理、商品管理、用户管理可进行按名称的模糊查询。<br/>
5.账单管理可进行按多个条件的查询。<br/>
6.订单添加页面使用了ajax进行异步请求，根据选择的商品名称 对应的供应商。并根据提供商和商品名返回唯一的商品信息，利用js进行自动填写。<br/>
7.基本的登录验证功能和密码修改功能，并使用js进行友好提示。<br/>

![image](https://github.com/chenxiaopan/supermarketmanager/raw/master/screenshots/supermarket1.jpg)

![image](https://github.com/chenxiaopan/supermarketmanager/raw/master/screenshots/supermarket2.jpg)

![image](https://github.com/chenxiaopan/supermarketmanager/raw/master/screenshots/supermarket3.jpg)
