#
# Author:: PhuongLM <phuonglm@teracy.com>
# Cookbook Name:: teracy-dev
# Recipe:: virtualenv
#
# Copyright 2013 - current, Teracy, Inc.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:

#     1. Redistributions of source code must retain the above copyright notice,
#        this list of conditions and the following disclaimer.

#     2. Redistributions in binary form must reproduce the above copyright
#        notice, this list of conditions and the following disclaimer in the
#        documentation and/or other materials provided with the distribution.

#     3. Neither the name of Teracy, Inc. nor the names of its contributors may be used
#        to endorse or promote products derived from this software without
#        specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# python_pip 'virtualenv' do
#     action :install
# end

bash 'download_pyenv_virtualenv' do
    code <<-EOF
        git clone https://github.com/yyuu/pyenv-virtualenv.git /home/vagrant/.pyenv/plugins/pyenv-virtualenv
    EOF
    not_if 'ls -la /home/vagrant/.pyenv/plugins/pyenv-virtualenv'
    user 'vagrant'
end

bash 'configure_virtualenv' do
    code <<-EOF
        source /etc/profile
        echo 'export PROJECT_HOME=/vagrant/workspace/personal' >> /home/vagrant/.bash_profile
        echo 'export PATH=$HOME/.bin/:$PATH' >> /home/vagrant/.bash_profile
        echo 'eval "$(pyenv virtualenv-init -)"' >> /home/vagrant/.bash_profile && source /home/vagrant/.bash_profile
    EOF
    environment 'HOME'=>'/home/vagrant/'
    not_if 'grep -q virtualenv /home/vagrant/.bash_profile'
    user 'vagrant'
end