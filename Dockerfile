FROM php:7.4-apache

# 安装必要的PHP扩展
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# 下载并安装ionCube Loader
RUN curl -fsSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz -o ioncube.tar.gz && \
    tar -xzf ioncube.tar.gz && \
    cp ioncube/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ && \
    echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_7.4.so" > /usr/local/etc/php/conf.d/00-ioncube.ini && \
    rm -rf ioncube ioncube.tar.gz

# 下载idcsmart.so扩展并放入相应目录
RUN mkdir -p /usr/local/lib/php/extensions/no-debug-non-zts-20190902 && \
    curl -o /usr/local/lib/php/extensions/no-debug-non-zts-20190902/idcsmart.so https://raw.githubusercontent.com/aazooo/zjmf/main/ext/finance/php7.4/idcsmart.so

# 修改php.ini文件，添加idcsmart.so扩展
RUN echo "extension=idcsmart.so" > /usr/local/etc/php/conf.d/idcsmart.ini

# 将当前目录中的所有文件复制到容器的 /var/www/html 目录中
COPY . /var/www/html/

# 设置工作目录
WORKDIR /var/www/html

# 开启apache模块rewrite
RUN a2enmod rewrite

# 设置Apache的DocumentRoot为/public
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|' /etc/apache2/sites-available/000-default.conf

# 添加伪静态规则
RUN echo '<Directory /var/www/html/public>\n\
  Options Indexes FollowSymLinks\n\
  AllowOverride All\n\
  Require all granted\n\
</Directory>\n' >> /etc/apache2/apache2.conf

# 创建并添加 .htaccess 文件内容
RUN echo '<IfModule mod_rewrite.c>\n\
  Options +FollowSymlinks -Multiviews\n\
  RewriteEngine On\n\
  RewriteCond %{REQUEST_FILENAME} !-d\n\
  RewriteCond %{REQUEST_FILENAME} !-f\n\
  RewriteRule ^(.*)$ index.php?s=$1 [QSA,PT,L]\n\
  SetEnvIf Authorization .+ HTTP_AUTHORIZATION=$0\n\
</IfModule>\n' > /var/www/html/public/.htaccess

# 给文件适当的权限
RUN chown -R www-data:www-data /var/www/html
