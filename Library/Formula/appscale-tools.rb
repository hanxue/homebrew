require 'formula'

class AppscaleTools < Formula
  homepage 'https://github.com/AppScale/appscale-tools'
  url 'https://github.com/AppScale/appscale-tools/archive/1.12.0.tar.gz'
  sha1 'be136970e89f024b11a05e1bd2719eb0121bf2bc'
  
  depends_on :python
  depends_on 'ssh-copy-id'
  depends_on 'swig'
  
  resource 'termcolor' do
  	url 'https://pypi.python.org/packages/source/t/termcolor/termcolor-1.1.0.tar.gz'
  	sha256 '1d6d69ce66211143803fbc56652b41d73b4a400a2891d7bf7a1cdf4c02de613b'
  end
  
  resource 'SOAPpy' do
  	url 'https://pypi.python.org/packages/source/S/SOAPpy/SOAPpy-0.12.5.tar.gz'
  	sha256 '8d8e3bf304f5669432d58cc0c2870766096ef5e4e89889aa1bce6d7a68994ef7'
  end
  
  resource 'pyyaml' do
  	url 'https://pypi.python.org/packages/source/P/PyYAML/PyYAML-3.10.tar.gz'
  	sha256 'e713da45c96ca53a3a8b48140d4120374db622df16ab71759c9ceb5b8d46fe7c'
  end
  
  resource 'boto' do
  	url 'https://pypi.python.org/packages/source/b/boto/boto-2.17.0.tar.gz'
  	sha256 '8ade8069e8fa273fd819da6604394bae194c3440842123ee8ca80e06976c2af5'
  end
  
  resource 'argparse' do
  	url 'https://pypi.python.org/packages/source/o/orgparse/orgparse-0.0.1.dev2.tar.gz'
  	sha256 '90e4df73fa4d0a6faa8e81a0b7c706e00ebd255b34649f04e1dedafb7f0a337c'
  end
  
  resource 'oauth2client' do
  	url 'https://pypi.python.org/packages/source/o/oauth2client/oauth2client-1.2.tar.gz'
  	sha256 '7ed84c327d61284bb32158ef1b3723106861efd64a8cc07e918a1db33d88fdbd'
  end
  
  resource 'google-api-python-client' do
  	url 'https://pypi.python.org/packages/source/g/google-api-python-client/google-api-python-client-1.2.tar.gz'
  	sha256 '3cb3f39c4a634950aee34f52e2a160b9a064b15210f7196ba364f670780aa675'
  end
  
  resource 'httplib2' do
  	url 'https://pypi.python.org/packages/source/h/httplib2/httplib2-0.8.tar.gz'
  	sha256 'cee59fdaa97a40ac505bb0629bdc8ba9ba79012d099ef11d6d3a284b7e369c9c'
  end
  
  resource 'python-gflags' do
  	url 'https://pypi.python.org/packages/source/p/python-gflags/python-gflags-2.0.tar.gz'
  	sha256 '0dff6360423f3ec08cbe3bfaf37b339461a54a21d13be0dd5d9c9999ce531078'
  end
  
  

  def install
    prefix.install Dir['bin'], Dir['lib'], Dir['templates'], ['README.md'], ['LICENSE']
    python do
      install_args = [ "setup.py", "install", "--prefix=#{libexec}" ]
      
      resource('termcolor').stage { system python, *install_args }
      resource('SOAPpy').stage { system python, *install_args }
      resource('pyyaml').stage { system python, *install_args }
      resource('boto').stage { system python, *install_args }
      resource('argparse').stage { system python, *install_args }
      resource('oauth2client').stage { system python, *install_args }
      resource('google-api-python-client').stage { system python, *install_args }
      resource('httplib2').stage { system python, *install_args }
      resource('python-gflags').stage { system python, *install_args }
    end
  end
  
  def patches
    # The main appscale-tools module is installed in the default location and
    # in order for it to be usable, we add the private_site_packages
    # to the __init__.py of ansible so the deps (PyYAML etc) are found.
    DATA
  end
end

__END__
--- lib/__init__.py	2013-11-05 07:02:27.000000000 +0800
+++ lib/__init__.py	2013-11-18 23:03:40.000000000 +0800
@@ -7,3 +7,5 @@
 
 Check us out on GitHub at http://www.github.com/AppScale/appscale-tools
 """
+import site; 
+site.addsitedir('#{python.private_site_packages}')
