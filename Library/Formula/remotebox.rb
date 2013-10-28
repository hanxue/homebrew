require 'formula'

class Remotebox < Formula
  homepage 'https://nobgoblin.org.uk/'
  url 'http://knobgoblin.org.uk/downloads/RemoteBox-1.6.tar.bz2'
  sha1 '3e73e722f1bfddae04b9465d28b1958d2caf0ee0'


  depends_on 'SOAP::Lite' 		=> :perl
  depends_on 'Gtk2'				=> :perl
  depends_on 'rdesktop'			=> :recommended


  def install
    prefix.install Dir['*']
    bin.mkdir
	bin.install 'remotebox'
  end
end
