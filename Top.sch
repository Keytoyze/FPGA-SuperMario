<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <blockdef name="clkdiv">
            <timestamp>2018-11-27T15:45:30</timestamp>
            <rect width="256" x="64" y="-128" height="128" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
        </blockdef>
        <blockdef name="Input">
            <timestamp>2018-12-20T8:36:9</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <block symbolname="clkdiv" name="XLXI_1">
            <blockpin name="clk" />
            <blockpin name="rst" />
            <blockpin name="clkdiv(31:0)" />
        </block>
        <block symbolname="Input" name="XLXI_2">
            <blockpin name="clk_1ms" />
            <blockpin name="btn(2:0)" />
            <blockpin name="left" />
            <blockpin name="right" />
            <blockpin name="jump" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="528" y="464" name="XLXI_1" orien="R0">
        </instance>
        <instance x="528" y="864" name="XLXI_2" orien="R0">
        </instance>
    </sheet>
</drawing>