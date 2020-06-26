#!/bin/bash

GIT_CORE="https://github.com/giellalt/giella-core.git/trunk"
GIT_SHARED="https://github.com/giellalt/giella-shared.git/trunk"
GIT_EXPEST="https://github.com/giellalt/lang-est-x-utee.git/trunk"

# sudo mount -o uid=1000,gid=1000 -t vboxsf gt-gramcheck jagatud

refresh_all_stuff()
{
    echo ==
    echo == refresh_all_stuff
    echo ==
    sudo apt-get -y update
    sudo apt-get -y dist-upgrade
}

get_basic_staff_from_Ubuntu_repos()
{
    echo == Ma ei tea, mida päriselt ka vaja on...
    echo == ${FUNCNAME[0]}
    echo ==
    sudo apt -y install subversion
    sudo apt -y install autoconf
    sudo apt -y install autoconf automake libtool libsaxonb-java python-pip
    sudo apt -y install python-lxml python-bs4 python-unittest2
    sudo apt -y install libxml-twig-perl antiword xsltproc
    sudo apt -y install poppler-utils wget python-feedparser subversion
    sudo apt -y install cmake
    sudo apt -y install python-tidylib python3-yaml libxml-libxml-perl
    sudo apt -y install libtext-brew-perl
    sudo apt -y install gawk flex 
    sudo apt -y install bison
    sudo apt -y install libgoogle-perftools-dev

    sudo apt -y install libhfst-dev libpugixml-dev libarchive-dev
    sudo apt -y install libcg3-dev
    sudo apt -y install -y swig
}

get_packages_from_Apertium_repo()
{
    echo == Ma ei tea, mida päriselt ka vaja on...
    echo == ${FUNCNAME[0]}
    echo ==
    # unhammer@fsfe.org said:
    # On Ubuntu, you should get packages like hfst, hfst-ospell and pugixml
    # from repos, and preferably remove anything you installed to
    # /usr/local. The only thing to build from source is divvun-gramcheck.
    # You get the relevant packages using

    # wget http://apertium.projectjj.com/apt/install-release.sh -O - | sudo bash
    wget https://apertium.projectjj.com/apt/install-nightly.sh -O - | sudo bash
    sudo apt-get update

    sudo apt-get -y install hfst hfst-ospell-dev libhfstospell11 
    sudo apt-get -y install apertium-all-dev
    sudo apt -y install divvun-gramcheck
 }

giella_core_sources_checkout()
{
    echo == 
    echo == ${FUNCNAME[0]}
    echo ==
    mkdir -p $HOME/giella
    pushd $HOME/giella
    svn co $GIT_CORE giella-core
    popd
}

giella_core_sources_update()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/giella-core
    svn up
    popd
}

giella_core_sources_build()
{
    #sudo apt-get install giella-core
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/giella-core
    ./autogen.sh
    ./configure
    make -j
    #sudo make install
    echo "export GIELLA_CORE=$HOME/giella/giella-core" >> $HOME/.profile
    . ~/.profile
    popd
}

giella_shared_sources_checkout()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    mkdir -p $HOME/giella
    pushd $HOME/giella
    svn co $GIT_SHARED giella-shared
    popd
}

giella_shared_sources_update()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/giella-shared
    svn up
    popd
}

giella_shared_sources_clean()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/giella-shared
    make clean
    popd
}

giella_shared_sources_build()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/giella-shared
    ./autogen.sh
    ./configure
    make -j
    #sudo make install
    echo "export GIELLA_SHARED=$HOME/giella/giella-shared" >> $HOME/.profile
    . ~/.profile
    popd
}

lang_est_x_utee_sources_checkout()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    mkdir -p $HOME/giella/
    pushd $HOME/giella/
    svn co $GIT_EXPEST lang-est-x-utee
    popd
}

lang_est_x_utee_sources_update()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/lang-est-x-utee/
    svn up
    popd
}

lang_est_x_utee_sources_clean()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/lang-est-x-utee/
    make clean
    popd
}

lang_est_x_utee_sources_clean()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    pushd $HOME/giella/lang-est-x-utee/
    make clean
    popd
}

lang_est_x_utee_sources_build()
{
    echo ==
    echo == ${FUNCNAME[0]}
    echo ==
    . $HOME/.profile
    pushd $HOME/giella/lang-est-x-utee/
    
    # see ei lisa muutujat GTLANG_est
    ./autogen.sh

    # Kui on vaja lisada keskkonnamuutuja GTLANG_est, igaks juhuks lisasin
    # see on pekkis hetkel 20200519 12.45
    #./autogen.sh -l
    #. ~/.profile

    ./configure --with-hfst --without-xfst  --enable-tokenisers  --enable-spellers --enable-grammarchecker

    make -j
    make check
    
    #sudo make install
    # et tekitada kataloogi modes, kus asuvad töövood
    pushd $HOME/giella/lang-est-x-utee/tools/grammarcheckers
    make dev
    popd
    popd
}

checkout_all()
{
  refresh_all_stuff
  get_basic_staff_from_Ubuntu_repos
  get_packages_from_Apertium_repo
  giella_core_sources_checkout
  giella_shared_sources_checkout
  lang_est_x_utee_sources_checkout
}

update_all()
{
  refresh_all_stuff
  sudo apt update && sudo apt dist-upgrade
  giella_core_sources_update
  giella_shared_sources_update
  lang_est_x_utee_sources_update
}

clean_all()
{
  giella_core_sources_clean
  giella_shared_sources_clean
  lang_est_x_utee_sources_clean
}

build_all()
{
  refresh_all_stuff
  giella_core_sources_build
  giella_shared_sources_build
  lang_est_x_utee_sources_build
}


checkout_build_all()
{
  checkout_all
  build_all
}

#
# Testimine eraldi skriptides
#


if [ -z $1 ]
then
  echo 'vaikimisi värskendame reposid ja rekompileerime'
  update_all
  build_all
else
  echo 'ainult seda: ' $1
  $1
fi




