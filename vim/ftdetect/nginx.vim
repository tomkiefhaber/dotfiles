" Nginx

au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx
au BufRead,BufNewFile /opt/local/etc/nginx/* set ft=nginx
au BufRead,BufNewFile nginx.conf set ft=nginx
