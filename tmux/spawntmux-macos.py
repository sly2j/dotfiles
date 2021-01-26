#!/usr/bin/env python3

import libtmux
import argparse

WORKDIR="~/Work"

SESSIONS={
        'jpsi': {
            'name': 'Jpsi-007',
            'workdir': lambda path: '{}/Jpsi-007/{}'.format(WORKDIR, path)}
}

## Jpsi-007 environment
def spawn(server, name, layout_func, workdir):
    session = server.find_where({"session_name": name})
    ## only re-create the session if it doesn't exist yet
    if not session:
        session = server.new_session(session_name=name, start_directory=workdir(''))
        layout_func(session, workdir)
    session.attach_session()

def window(session, name, workdir):
    win = session.new_window(
            window_name=name,
            start_directory=workdir,
            attach=False)
    return win

def split_window(session, name, workdir):
    win = session.new_window(
            window_name=name,
            start_directory=workdir,
            attach=False)
    win.split_window(attach=False, vertical=False, start_directory=workdir)
    return win

def jpsi_layout(session, workdir):

    ## Jpsi xsec analysis window
    jpsi = split_window(session, 'Jpsi', workdir('Analysis/Jpsi'))

    ## Pc sensitivity study
    pc = split_window(session, 'Pc', workdir('Analysis/Sensitivity'))

    ## Simulation
    sim = split_window(session, 'Simulation', workdir('Analysis/Simulation'))

    ## Replay
    replay = window(session, 'Replay', workdir('Replay'))
    replay.split_window(
            start_directory=workdir('Software/hallc_replay_common'),
            vertical=False,
            attach=False)

    ## Software
    soft = window(session, 'Software', workdir('Software/simc'))
    soft.split_window(
            start_directory=workdir('Software'),
            vertical=False,
            attach=False)

    ## Jupyter
    jupyter = session.new_window(
            window_name='Jupyter',
            attach=False,
            start_directory=workdir('Analysis'))
    jupyter.select_pane('-U').send_keys('jupyter lab --no-browser')


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('session',
            help='session to start')
    args = parser.parse_args()

    server = libtmux.Server()
    spawn(server, 
          SESSIONS[args.session]['name'], 
          locals()['{}_layout'.format(args.session)],
          SESSIONS[args.session]['workdir'])
