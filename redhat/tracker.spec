Name:           tracker
Version:        1
Release:        1
Summary:        Automatically track your contracting time on projects.
BuildArch:		noarch
Group:          Utility
License:        GPL
URL:         https://github.com/bschwagg/tracker   
Source0:        %{name}-%{version}.tar
BuildRoot:     %{_tmppath}/%{name}-build
#BuildRequires:  

%description
Automatically track your contracting time on projects.

%prep
%setup -n %{name}-%{version}

%pre
#pyinotify ?
echo "installing when-changed tool..."
pip install https://github.com/joh/when-changed/archive/master.zip

%post
systemctl daemon-reload
systemctl enable tracker
systemctl start tracker

%build

%install
# create directories where the files will be located
mkdir -p $RPM_BUILD_ROOT/opt/tracker
mkdir -p $RPM_BUILD_ROOT/opt/tracker/logs
mkdir -p $RPM_BUILD_ROOT/usr/lib/systemd/system

# put the files in to the relevant directories.
install -m 755 tracker.service $RPM_BUILD_ROOT/usr/lib/systemd/system/
install -m 755 *.sh $RPM_BUILD_ROOT/opt/tracker
install -m 755 *.py $RPM_BUILD_ROOT/opt/tracker
#install -m 755 *.ini $RPM_BUILD_ROOT/opt/tracker
ln -fs  /opt/tracker/tracker.sh /usr/bin/tracker

%clean
rm -rf $RPM_BUILD_ROOT
rm -rf %{_tmppath}/%{name}
rm -rf %{_topdir}/BUILD/%{name}

%files
%doc README.md
/opt/tracker/createRPM.sh
/opt/tracker/entryAll.sh 
/opt/tracker/entry.sh 
/opt/tracker/tracker_register.sh  
/opt/tracker/tracker.sh  
/opt/tracker/trackerStart.sh  
/opt/tracker/trackerStop.sh 
/opt/tracker/tracker.py
/usr/lib/systemd/system/tracker.service

%changelog
* Sun May 31 2015 Brad Schwagler <brad.schwagler@gmail.com> 1.0
- Initial release