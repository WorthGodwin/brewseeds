class Bitseeds < Formula
  desc "BitSeeds OS X client (GUI and CLI)"
  homepage "http://bitseeds.org"
  head "https://github.com/BitSeedsOrg/Bitseeds.git"

  option "with-cli", "Also compile the command line client"
  option "without-gui", "Do not compile the graphical client"

  depends_on 'boost'
  depends_on 'berkeley-db4'
  depends_on 'openssl'
  depends_on 'miniupnpc'
  depends_on 'libzip'
  depends_on 'pkg-config' => :build
  depends_on 'qrencode'
  depends_on 'qt'

  def install

    if build.with? 'cli'
      chmod 0755, "src/leveldb/build_detect_platform"
      mkdir_p "src/obj/zerocoin"
      system "make", "-C", "src", "-f", "makefile.osx", "USE_UPNP=-"
      bin.install "src/BitSeedsd"
    end

    if build.with? 'gui'
      system "qmake", "USE_UPNP=-"
      system "make"
      prefix.install "BitSeeds.app"
    end

  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test BitSeeds`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end