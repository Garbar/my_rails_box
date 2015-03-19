node.default[:packages] = %w(
  curl
  mc
  imagemagick
  libmagickwand-dev
  zsh
)
node.default['repository'] = "git://github.com/robbyrussell/oh-my-zsh.git"
node.default['users'] = [
{
  :login => 'deploy',
  :plugins => ['gem', 'git', 'rails', 'ruby'],
  :home => '/home/deploy' # optional
}
]
node.default['secret_key'] = "c801b19d14f41ebe9c484d4ac6cfd886c67d29373bcd960bf1e312c61cebee85475a7a899efff05c9b27b271e83b07daea1c10b88a707247ca296f407b52979e"
