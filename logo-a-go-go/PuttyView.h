//
//  PuttyView.h
//
//  Created by Tyler Neylon on 6/16/10.
//  Copyleft 2010.
//
//  This is a view that can be dragged around
//  or resized using the lower-right corner.
//

#import <Foundation/Foundation.h>


@interface PuttyView : UIView {
 @private
  // strong
  UIImageView *contentView;  // Retained as a subview.
  
  CGPoint touchStart;
  BOOL isResizing;
}

@property (nonatomic, retain) UIImageView *contentView;

@end
