<?xml version="1.0" encoding="utf-8"?>
<!-- Created by Leo: http://leoeditor.com/leo_toc.html -->
<leo_file xmlns:leo="http://leoeditor.com/namespaces/leo-python-editor/1.1" >
<leo_header file_format="2" tnodes="0" max_tnode_index="0" clone_windows="0"/>
<globals body_outline_ratio="0.5" body_secondary_ratio="0.5">
	<global_window_position top="50" left="50" height="500" width="700"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="sgoda.20170120160529.1" a="E"><vh>Startup</vh>
<v t="sgoda.20170120160529.2" a="E"><vh>@settings</vh>
<v t="sgoda.20170120160529.3"><vh>@string initial_split_orientation = horizontal</vh></v>
<v t="sgoda.20170120160529.4"><vh>@shortcuts</vh></v>
<v t="sgoda.20170120160529.5"><vh>Buttons</vh>
<v t="sgoda.20170120160529.6"><vh>@button lsdir @color=pink</vh></v>
<v t="sgoda.20170120160529.7"><vh>@button mk_nodes @color=purple</vh></v>
<v t="sgoda.20170120160529.8"><vh>@button mk_clean_nodes @color=cyan</vh></v>
<v t="sgoda.20170120160529.9"><vh>@button mk_path_nodes @color=green</vh></v>
<v t="sgoda.20170120160529.10"><vh>@button node_mute @color=magenta</vh></v>
<v t="sgoda.20170120160529.11"><vh>@button node_unmute @color=green</vh></v>
<v t="sgoda.20170120160529.14"><vh>@button create_node_sections.py color=yellow</vh></v>
</v>
<v t="sgoda.20170120160529.15"><vh>Commands</vh></v>
</v>
</v>
<v t="sgoda.20170120161146.1" a="E"><vh>Crafting Interpreters</vh>
<v t="sgoda.20170120161157.1"><vh>local repo</vh></v>
</v>
</vnodes>
<tnodes>
<t tx="sgoda.20170120160529.1"></t>
<t tx="sgoda.20170120160529.10">@language python

if p.h.startswith('@'):
    p.h = '@' + p.h

c.redraw_now()</t>
<t tx="sgoda.20170120160529.11">@language python

if p.h.startswith('@@'):
    p.h = p.h[1:]

c.redraw_now()</t>
<t tx="sgoda.20170120160529.14">@language python

copied_p = p.copy()

SECTION_START = "&lt;" + "&lt;"
SECTION_END = "&gt;" + "&gt;"

for line in p.b.split('\n'):
    if line.startswith('@'):
        continue
    if line.startswith(SECTION_START) and line.endswith(SECTION_END):
        h = line.strip(SECTION_START + SECTION_END)
        child = copied_p.insertAsLastChild()
        child.h = SECTION_START + h + SECTION_END

c.redraw_now()</t>
<t tx="sgoda.20170120160529.15"></t>
<t tx="sgoda.20170120160529.2"></t>
<t tx="sgoda.20170120160529.3"></t>
<t tx="sgoda.20170120160529.4">refresh-from-disk=CTRL+SHIFT+R</t>
<t tx="sgoda.20170120160529.5"></t>
<t tx="sgoda.20170120160529.6">@language python

import os

cwd = os.getcwd()

files = os.listdir(cwd)


g.es("\nContents of {0}\n".format(cwd), color='green')
g.es("\n")
# g.es("\n".join(files))

for entry in files:
    color = 'black'
    suffix = ''

    if os.path.isfile(entry):
        color = 'cyan'
    elif os.path.isdir(entry):
        color = 'blue'
        suffix = '/'
    
    if entry.startswith('.'):
        color = 'gray'
    
    g.es("{0}{1}".format(entry, suffix), color=color)

g.es("\n")</t>
<t tx="sgoda.20170120160529.7">@language python

if p.h.startswith('@button'):
    raise ValueError("Watch what you click!")

copied_p = p.copy()

child_names = (child.h for child in p.children())
URL_BASE = "https://github.anim.odw.com.cn/dmc/{0}"

if not p.b.split():
    raise Exception("""For creating children for the selected node
    The body of the seelcted node must contain the name of the child 
    specified one per line.
    """)

for line in p.b.split():
    if not line:
        continue
    # There could be a path or language directive
    if line.startswith('@'):
        continue

    if line in child_names:
        g.es("Already exists: {0}".format(line), color='red')
        continue

    child = copied_p.insertAsLastChild()
    child.h = line
    child.b = URL_BASE.format(line)

c.redraw()</t>
<t tx="sgoda.20170120160529.8">@language python

if p.h.startswith('@button'):
    raise ValueError("Watch what you click!")

copied_p = p.copy()

#child_names = (child.h for child in p.children())
#URL_BASE = "https://github.anim.odw.com.cn/dmc/{0}"

if not p.b.split():
    raise Exception("""For creating children for the selected node
    The body of the seelcted node must contain the name of the child 
    specified one per line.
    """)

for line in p.b.split('\n'):
    if not line:
        continue
    # There could be a path or language directive
    if line.startswith('@'):
        continue

    #if line in child_names:
    #    g.es("Already exists: {0}".format(line), color='red')
    #    continue

    child = copied_p.insertAsLastChild()
    child.h = '@clean {0}'.format(line)
    #child.b = URL_BASE.format(line)

c.redraw()</t>
<t tx="sgoda.20170120160529.9">@language python

import os

cwd = os.getcwd()

if p.h.startswith('@button'):
    raise ValueError("Watch what you click!")

copied_p = p.copy()

child_names = [child.h for child in p.children()]


for line in os.listdir(cwd):
    # if not line:
        # continue
    
    # There could be a path or language directive
    # if line.startswith('@'):
        # continue
    
    if line in child_names:
       g.es("Already exists: {0}".format(line), color='red')
       continue
    
    # Do not process hidden files and directories
    if line.startswith('.'):
        continue

    child = copied_p.insertAsLastChild()
    
    # Create file nodes
    if os.path.isfile(line):
        if line.endswith(".py"):
            child.h = '@@clean {0}'.format(line)
        elif map(line.endswith, (".yml", ".md")):
            child.h = '@@edit {0}'.format(line)
        elif line.endswith('.png'):
            child.h = '@image {0}'.format(line)
        else:
            child.h = '@@edit {0}'.format(line)
    # Create directory nodes
    elif os.path.isdir(line):
        child.h = line
        child.b = "@path {0}".format(line)

c.redraw()</t>
<t tx="sgoda.20170120161146.1">http://craftinginterpreters.com/
https://github.com/munificent/craftinginterpreters
https://github.com/satishgoda/craftinginterpreters</t>
<t tx="sgoda.20170120161157.1">@path ./</t>
</tnodes>
</leo_file>
