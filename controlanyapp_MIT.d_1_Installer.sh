#!/bin/bash

#########################################
# SNMPGW Self-Installer Script
#########################################
#
# Author:  Hermann Maurer
# Email:   hmfetch@gmail.com
#
# COPYRIGHT (c) 2018 Hermann Maurer
#
#########################################
VERSION="1.00"
#########################################
# cp selfInstallerTemplate.sh SNMPGW_1_0_Installer.sh
# cat SNMPGW_1_0_20181001_150429_1.06.tar.gz >> SNMPGW_1_0_Installer.sh

ID="CONTROL"
IGNORDELIVERYDIR=$1;
###
### SAFE MODE
###
echo
echo "Installation of $ID: Continue - press <c>, Quit - press <q>,"
read -n 1 -s CSQA
if test "$CSQA" == "c"; then
        echo continue
elif test "$CSQA" == "q"; then
        echo quit
        exit
else
	echo quit
	exit
fi

cat <<__END__

##########################################

  Started CONTROL Self-Extracting Script

##########################################

__END__

set -x

# use absolute path
ROOTDIR="/opt/CONTROL"
LOGDIR="$ROOTDIR/install_log.d"
DELIVERYDIR="$ROOTDIR/installer.d"
DATE=$(date +%Y.%m.%dT%H:%M:%S)
LOGFILE="$LOGDIR/${ID}_${DATE}.log"
INSTALLDIR="controlanyapp_MIT.d"
INSTALLSCRIPT="$ROOTDIR/$INSTALLDIR/install.sh"

function preconditions {

	set +x
	echo "########################"
	echo "INSTALLER: preconditions"
	echo "########################"
	set -x

	if [ "$(uname -o)" != 'Cygwin' ]; then
		if [ "$(id -u)" != "0" ]; then
		
			echo "need root user for execution: sudo $0"
			return 1;
		fi
	fi

	mkdir -p "$ROOTDIR" && \
	mkdir -p "$LOGDIR" && \
	mkdir -p "$DELIVERYDIR"
}

function extract {

	set +x
	echo "##################"
	echo "INSTALLER: extract"
	echo "##################"
	set -x

	archive=$(grep --text --line-number 'ARCHIVE:$' $0 | cut -d: -f1) && \
	tail -n +$((archive + 1)) $0 | gzip -vdc - | tar -C "$ROOTDIR" -xvf - > /dev/null
}

function install {

	set +x
	echo "##################"
	echo "INSTALLER: install"
	echo "##################"
	set -x

	if [ "$IGNORDELIVERYDIR" != "" ]; then

		echo "IGNOREDELIVERYDIR";
		$INSTALLSCRIPT
	else

		[ ${#INSTALLDIR} -ne 0 ] && $INSTALLSCRIPT && \
		mv $0 "$DELIVERYDIR"
	fi
}

function success {

        cat <<END
#######

SUCCESS

#######

Installation complete!

END
        exit 0;
}

function failure {

        cat <<END
#######

FAILURE

#######

Please provde the log file [$LOGFILE] for troubleshooting.

END
        exit 1;
}

############
# MAIN START


mkdir -p "$LOGDIR" && \
( preconditions && extract && install && success || failure ) 2>&1 | tee "$LOGFILE"
exit
# MAIN END
############

ARCHIVE:
��7\controlanyapp_MIT.d_20181208_223028_1.tar �<�WI����+n���׷(NP1���G����i��N�n�n4�q���ު�c��ff���	�Uu�u�>�
z��9��[3}2�9kt����WĿ��m�,�n���ߛ��Vq��������X�,�Ko`������� ��h�g�}������d��vj��g/��bygg�\����.���>�G�����i�����S������̿�s���o�y�����y�w��V��Vi;��˥���(����o��>�Cr�+����S��������=?�eXCWv�^�O����%�%p`�u���6�A��W�cݰ*���h�t��[�z'��5�M����\�F>D�����=ݓ��ۏU�=,PL��ě�d���;�������(�=��_��E�_~~뺏����\��.���]�*���������������K����-`X�z#۩ �2g�[��S�9�S�ob����F�Ԑ��cx�>��i�?�B�����Y@���S���;Z�݂*�Œ������.Rw&p����7`��(A�]��R�0�����]c�*�S��\��5#{��ZKk٦-�&;խ��� �ùi�ô>��9uG|�y[k���"�nBS��.��1���E��
;�^�����j���a��]�oO=EQ��-���#@��]�쎌�'���6ѐ5��ћ�W��5��g�V��#m�h.󨭘/���cܳ>{.��Tw9���gD�$�L�^5��M�9�b&s�yMA�����f�Ԝ�_u���z#��D-�l�OM����%e���-r30,���<��J��i@=�J�c$+✬=3]��A�*l1HiG�f����Q�A�b��e�,��ʩ�gh):���,։�� Т$_�tj8�� � ZQ�\�*j��p^�轕"�C��$p>�S_��w��`B�~: �Az�^hzH��'�,�y)��2�
�R���K��{f�5�2��53�s�I9�'3�9�g��6+_�1\�}j���\v7eV�)k�1��ҟh*�r�G��b�#{j�Bt3�!��c߮�Z��Ez�$CU�H`��6
c�����>*��E(X�&*%��6W-1�)��}.����^wW7�N�g��oS�L�̂��[�>�0n��y2U���
�Z�eW�PE`�ս�r	�C���K0д���Κ|J/�/Ǝ?M�-�d�q?�,Â�2��\���O��:��p��+=��0wb[.�u�9�����aP�|�S)�[��q���ac��,�s=.8N�e���dKYs�7u,�^^9Px��:��T�����j� Xù�wϜ[��[��(Fb�/F����t��ZC����N�i[C� �������޹�C��<���[�����O�.z^��U�AF��.��؀2�3A=P�,2M������Z��i7�$+���-�Q��YG>��$�7���)�ς�biՔ���VS5j��#�Ҭ���#&)����IQ���ղ����A.����G��m��t	�4�KE�{-������UX��z.)g����>r���k�NV�"�%��VI�֠R�r �n1HP��Qt>U�]t�����KU|�����`����J���K�XͿ�d��;*�l�^����cw��Kqwg���&v]]�a���>fo�ma��@����K�ehK,�{����C���?\�P�$\T�(���-GR�s�qm-8��/rU�K q��3�DD�	�>�A.={8��+)_�|������q�.M��,�t�Q�*�d��]Y���%ڴ
��t�W�gz���g���4�t�D[��#ּ��X���PX�<'(*&K�}�a��>��TQ>~�����%�Ln������������A��ب�{T��~Z�j'��8i�ރV�V��0��Sp1��r�]�]2��*U���wb��BI��!���2{�|�#J�4<Ϊ*X��>D�#�-U;lw�)�W�����ww�5w�zl�i��f�,2���?
��_Y1���N�#�#}��3.=_��V����1�����y�0
�g&>[27Ờ1�|���g.U��OB���*e=�K0��Ty�����ʀ�V�ߋz����IN����%El��`�d5�.�*D\x��w/���	�!�A�ɸoZ[��g�;\�'W	ȉ�1�f�˗�*_�9ga�6�?�V"��쇦��"/�G�p*}��^+P�������	�ks���1��%�D]��خA�Ȥ�5�jw����&��"ضx�uG�W"�n��q�;鳼��*Ϯ
i�����5���`�,H�_l�1_��Zr���c��N+�g�uLitt+������bz�yD��z#t�����բ���"�X�~`������>�sתM��|fl�SB�$�x�E_��T�?�/ZiOn����+q�]�c��,c8�V��*��n�.�]�0ca�3:��~�ܨ��tgȨ<��a��ط�n�&+�=$��Ho�h\{�=�iȂt׵{����o�����S���\H�ͩ��P3�H�a�d{���B�F����W��"�>��>��w��ؐ���*�t��'V$v��'�bM���A�9}�P�N=lt��+2Krh;W����r���R�'U�R�Èv=���2�0�$ŮQ�F�q�Y���߁m����هȍ݊�t�K�%s�Ӌ��*X�	���*���̦�.�W���y\6�g`>����͋�G��u��'��j�:448�m׏A�i����[�{ھ��o�����}�����:�B�睺�A��4�Λ�:�5ZG͋�F�="z'h6Вi�DP�j�5BvV���k���lt?d��F�E8O���y��m]4k8�蜷�:�?F��F뤃T�g�V7�T���h��f�H)��C�EN8N��c�O�NF�j�ͺ �B5k��,��j����X:
��o�uj"z5�wԥ4���/�fQ�N7 ���ճP�44R�I�}�UH���H�UXH��B�Z=@��ZqiL"����X��K����й$��|"�&�d� �������!N���(^�D��>�l_B}�D�&=�|���S�XX|P%�@��D�O>�:�����;P�A���^"̣�Y��U����"F2y��.�V
#~E�p1F �� 5l�:�d��L]�3E�U>Bd,	������).'�S�[R�Xvs��I��3�֧B�=`V�X�g���X�P���)����Ҿ�'�23%jd+m�%&�{���e��G'U���O���~����|<Ѯ*���`�>䌞n� �6�C�*�S%4ֈ�.7U%0�!�zi��8l���U�e��UC]�d�"�V*7Q��Ie�XW)#ͫ*��w)���v�h@뢩(ˬ^Y�y��y�������o%�OLLG��gN���ꝓ�*�/�yU���\��X5l�m:��s���8{��-Ԏ�~�aP����w��b���R�H���a]��w�WreE������4ڷ|��#����<��;��K�>?�P��(���`l���K�����x��\�S䌧��p�����^,��|�?!�iM;]!�yF�1�l�H:��ѾD���.e_\��~��{E�q���VDё��P�v�5Y(��x�F��+?�w��ڮ����$b����Ca��å*���(�����}o6����Y�@iq�������ۃB���jM���
|����a�fS����*_��˙\2�+RV�|���Y��}~lƝ����[�Lx�'�G���o8K6˖�ʭQ��MX��0��e��G�XũkF��s��.~��	6�-�L��A���tX�n��/<F��(8�����;|~w�W��}������Q�������������y������{~�w��Y,�7���K�����?�/�
S�)�Va��ۮ2*��=زK�tmi�[C�l��htQ�d��=�]�+��[oD�~?E8�B���?����هZ/���#�qKw������[�K.�j�n�oVpɰ��:�X�8��_K�&���8��ݺ֕����zҹǲ���gy�,
�	����9 �P�3A8%1�A���_� .5~ֆ5#.E�ɏ�Q���?��/�A�FЁ���_f!�b�6�y[�:�ݞ3��nj���(�[�ve�/���'��螃ѽ������H���c0b7s��GT������:x �i��vi9A��z���ץRa7,h�*�.��/7����J+|�Y�X���5��-^_�ԇl��=�|��\��0��m��/Ṷ��z�[�t����}�5��}�?y�_�&��]��\�W����|��?*��$�?���|y���㬊�a����_p���X�u�]yH���E�,�Z�Z�5-�1iA0��z\)6��z`96ps��M?#I|���52�q�߰p��f�}��X�K;�񿴍)�k�����VwGX0r��\�ӣl��S6���j�fӿC[k}����<�O�q�����R��L��f��@��!��u����������g��b�#H����z��>�88P����ѡ^�^ ��e��Z 鳉iϖA��6V��
��2�<�0:�ƌ�b{зw�iF7>/4z����:��$zʒ��KP�?��u�"���X+w��Iei�l``�m}IE��N{=��h/4נt�.���$w����Zaq/�V~��+hOj��E���G+̏�V�������4|�%��%����G�y�������[��?�v���ۻ���G�����\�5���q�x.~�;�����~��D�������i�_�k�wV_��7������fq�����k������/Q�������T�R�XT���^Vk���6��6�o�J���vG�}�9�3 �җ��߮72��'���F)��)���=C�<�V]̡�͓F�~vެu��<����܀��0h�d�9]6��hh	���`�F��Q����G]��}A@�'H=�>�t�$��z��p|���s��ȑ�H�'UvD����_UIt���pӭuk�&�%�a�Ͽ����}E���GI��&^��Ȳ�&�%��G��*�s�c�U��q���OŴ��>�Ւ�����5��$H
I	���Q��ῌ	�����C�A�r�hi]��wrb�ׄ8Oj2fLjP*k�C �uW�M`mhe��֛,"�����s�f)O~�/�5�e�Fc�Ӎ�s���x�[�cL�^�gC��|D�Ѹ�1�L�hVrj�~ޣ �T�'�O�¥.���`��
��os��R%��������a!?��H�}����H����b{09q�R���4
W���4�O�$�X-O'�ė��^�e|�G��D�\���[��9:���$�K�Fx$�8��s�����|�w���v����������vʯ����~g�������6��*�����OV&DRQ7��b,��_{��Ӹ���%�=�
�ab'����E$��(���T!0\D.���A�}���>�8/d�+ڕ`�>���ݙ���d���G�4�v�U��ͨ�(�70�I帨y��gn��e�vT����Z�+"G�������Z�'�i
QHȯ)�7���!�y�3�Y <5����`�G��~�io�w�
:谈vp�~�������]�_�YL�JT\!+ӧ�L��2o]9Oq�K���旸�F���h,0�W��U� f���T+U5E*[V�Ԣy9�Qe��������8z~������ӂx/Uu�}��1"�.H�ey)�n~�q�(澎U�T?�Av^Y��T��4���1WzTKQJ��-)蜆��O*b4ޘ��s\R���@	�;ɲ�9J�#�U�ڈkAw�t����[�U%�9��`ĩ��7W��E_d��'	�Ҁ������m��8�c	��r`
�Swh���+zS�Y������j��O�z:��E~j.կM.������&�!�_�O
�����Ӄ���;�U�8�A�h��Z�.�l\ w��p�e��λ<?��__�F���ρ�o�������ۓ4z����>S(�q�d�dEHX3)ɉCb�A�m|:��W�赘�\�O�]�R;tbj���A	�&��^;�oܗ�ι���ޤ������w��� ��Z����л�X���o��T{SLZ�IKq-���K,��Rp\��	[��8�y��h�%7�tV."��y�^�������U�T�������Y�_j�s�r@\�k�/���.��������?'��ƿ���J���؀��i���Y��_X����#��)E����e�����4�1�LS�l^ݍz	:�(M�m*�cJG�cuU֐*����VH�$�|�%w�=�"�B2�4�G�ݎ��"�:�됮'U��~3Я�nX�J�8����m/Q���O�N�p�T'�y�:�Iڙqn�Vp�Yg���]�����8_����lr����vY�J F��߲�ߖ��σ��?t�)@mzS}޾16��C!��5 ���h��R~��~�k�eQ��rG���{/���Y>��\��g�F����p���{ �P�ը�%����ҋ=5څ;y���&k�����?�E��W�Kט�LI�4�N��f��ܗ
o5�F��-`y�!:�rɡ7w*��h@�'��b�p�3A��Hx�F���ʼ�3I|��Zq�.�~��RxPC��ڟ5�⚞,F��ː-�Z7BF�(�I����i�Ҹ�:�� ڈCU�B���@m?@:��ì[�/���5�U��nA��%l0�#`�����+��a��#���JY���JD����_��o����^zxq�uZ��2��3a�
��lt�*a*�ZQM�Z+�U&�Մ�����Y��t�q�Q��l��ʂb'���ck{�l�?��`cY��"�pچ�)����,̶i�0�-�q��{˅/�]^�5?�f�s�q��ݵ�g��htuG��u� 0�]�s1YOj������q���6(4��v��������E8��?'����������⿗�����͎ـDyFm��������/p��O��١p����-����[�/� ^���B8x��p�����(8����&��6�y�~�G����+*o[��|��4��=�_X��dYpSZw��%�ws�O��q^;Q����煮:
JF���<�:7�������dH�� ���'���傟2aNv��&�l��&�l��&�l��&�lz��_�G'� �  