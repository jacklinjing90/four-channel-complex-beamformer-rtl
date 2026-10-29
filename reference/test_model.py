"""Standalone Python model check; does not simulate Verilog RTL."""
def combiner(samples,weights):
    sat=lambda v:max(-32768,min(32767,v))
    i=sum(x[0]*w[0]-x[1]*w[1] for x,w in zip(samples,weights))>>7
    q=sum(x[1]*w[0]+x[0]*w[1] for x,w in zip(samples,weights))>>7
    return sat(i),sat(q)

def run():
    assert combiner([(100,-100),(200,-200),(300,-300),(400,-400)],[(64,0)]*4)==(500,-500)
    assert combiner([(100,-100)]+[(0,0)]*3,[(0,64)]+[(0,0)]*3)==(50,50)
    print('PASS: Python complex beamformer reference')

if __name__=='__main__':run()
