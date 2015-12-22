//
//  GameViewController.h
//  flappy
//
//  Created by Rachel on 15/12/19.
//  Copyright © 2015年 Rachel. All rights reserved.
//

#import <UIKit/UIKit.h>

int bird_speed;
int old_height;
int random_toptunnel_pos;
int random_bottomtunnel_pos;
int score;
@interface GameViewController : UIViewController
{
    IBOutlet UIImageView* imview_bird;
    IBOutlet UIButton *btn_startgame;
    
    IBOutlet UIImageView* imview_tunnel_top;
    IBOutlet UIImageView* imview_tunnel_bottom;
    IBOutlet UIImageView* imview_top;
    IBOutlet UIImageView* imview_bottom;
    
    NSTimer *timer_bird_move;
    NSTimer *timer_tunnel_move;
    
    IBOutlet UILabel* label_gameover;
    IBOutlet UILabel* label_score;
    IBOutlet UIButton* btn_return;
}


-(void)Gameover;
-(IBAction)Startaction:(id)sender;
-(void)BirdMoving;
-(void)TunnelMoving;
-(void)PlaceTunnels;
-(void)IncScore;

@end
