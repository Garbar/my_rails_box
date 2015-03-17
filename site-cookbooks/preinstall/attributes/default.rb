node.default[:packages] = %w(
  curl
  mc
  imagemagick
  libmagickwand-dev
  zsh
)
node.default['repository'] = "git://github.com/robbyrussell/oh-my-zsh.git"
node.default['users'] = [{
  :login => 'vagrant',
  :theme => 'rachel',
  :plugins => ['gem', 'git', 'rails', 'ruby'],
  :home => '/home/vagrant' # optional
}]
