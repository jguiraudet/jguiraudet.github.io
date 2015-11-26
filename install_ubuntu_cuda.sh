
# Install cuda if found an NVIDIA card
if lspci -vnnn | grep -i nvidia; then
	cd /tmp
	wget http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1404/x86_64/cuda-repo-ubuntu1404_7.5-18_amd64.deb
	sudo dpkg -i cuda-repo-ubuntu1404_7.5-18_amd64.deb
	sudo apt-get update
	sudo apt-get install -y cuda

	# Check samples
	/usr/local/cuda-7.5/bin/cuda-install-samples-7.5.sh /tmp
	cd /tmp/NVIDIA_CUDA-7.5_Samples/1_Utilities/deviceQuery
	make
	./deviceQuery 
	cd /tmp/NVIDIA_CUDA-7.5_Samples/1_Utilities/bandwidthTest/
	make
	./bandwidthTest
	rm -fr /tmp/NVIDIA_CUDA-7.5_Samples
fi

