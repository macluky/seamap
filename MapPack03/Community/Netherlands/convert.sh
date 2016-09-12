
target=$1/doc.kml

function writeTile {
    echo "        <GroundOverlay>"
    echo -n "            <name>"
    echo ${mapname}
    echo "               </name>"
    echo "            <drawOrder>1</drawOrder>"
    echo "            <Icon>"
    echo -n "                <href>"
    filename=`cat $1 |grep "^fname = " |cut -d = -f 3 |cut -c 2-`
    echo ONC-${filename}
    echo "                </href>"
    echo "                <viewBoundScale>1.00</viewBoundScale>"
    echo "            </Icon>"
    echo "            <LatLonBox>"
    echo -n "                <north>"
    echo $north
    echo "               </north>"
    echo -n "                <south>"
    echo $south
    echo "                </south>"
    echo -n "                <east>"
    echo $east
    echo "                </east>"
    echo -n "                <west>"
    echo $west
    echo "                </west>"
    echo "            </LatLonBox>"
    echo "        </GroundOverlay>"
}

function writeHeader {
    echo "<kml>"
    echo "    <Folder>"
    echo -n "        <name>"
    echo  "$1"
    echo    "       </name>"
}


function writeFooter {
    echo "    </Folder>"
    echo "</kml>"
}

if [ "${1}" = "" ]
then
    echo "Syntax: $0 folder"
    exit 1
fi

function getName () {
    mapname=`cat $1 |grep "^name = " |cut -d = -f 3 |cut -c 2-`
}

function getCorners () {
    north=`cat $1 |grep "^nord = " |cut -d = -f 3 |cut -c 2-`
    south=`cat $1 |grep "^sued = " |cut -d = -f 3 |cut -c 2-`
    east=`cat $1 |grep "^ost = " |cut -d = -f 3 |cut -c 2-`
    west=`cat $1 |grep "^west = " |cut -d = -f 3 |cut -c 2-`
}

writeHeader $1 > $1/doc.kml


for map in $1/*.cal
do
    getName $map
    getCorners $map
    writeTile $map >> $1/doc.kml
done

writeFooter >> $1/doc.kml
