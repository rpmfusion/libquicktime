

cvs -d:pserver:anonymous@libquicktime.cvs.sourceforge.net:/cvsroot/libquicktime login
cvs -z3 -d:pserver:anonymous@libquicktime.cvs.sourceforge.net:/cvsroot/libquicktime co -P libquicktime
cd libquicktime
git cvsimport -v

In github.com press + and new repository, choose repository name: libquicktime
without "Initialize this repository with a README" .
and run:

git remote add origin git@github.com:sergiomb2/libquicktime.git
git push -u origin master

and I got this :
https://github.com/sergiomb2/libquicktime/commits/master

and with:
git remote set-url origin ssh://sergiomb@git.code.sf.net/p/libquicktime/git
git push -u origin master

and we got :
https://sourceforge.net/p/libquicktime/git/ci/master/tree/
